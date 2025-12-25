//
//  BrowseViewModel.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//

import Combine
import Foundation

final class BrowseViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var selectedCategory: EventCategory = .all
    @Published var searchText: String = ""
    @Published var events: [Event] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Computed Properties
    var filteredEvents: [Event] {
        let searchFiltered = searchText.isEmpty ? events : events.filter { event in
            event.title.localizedCaseInsensitiveContains(searchText) ||
            event.eventTypeName.localizedCaseInsensitiveContains(searchText) ||
            formattedLocation(for: event).localizedCaseInsensitiveContains(searchText)
        }
        
        if selectedCategory == .all {
            return searchFiltered
        }
        
        guard let apiCategoryName = apiCategoryName(for: selectedCategory) else {
            return searchFiltered
        }
        
        return searchFiltered.filter { event in
            event.eventTypeName.lowercased() == apiCategoryName.lowercased()
        }
    }
    
    var hasEvents: Bool {
        !events.isEmpty
    }
    
    var hasFilteredEvents: Bool {
        !filteredEvents.isEmpty
    }
    
    var filteredEventsCount: Int {
        filteredEvents.count
    }
    
    var totalEventsCount: Int {
        events.count
    }
    
    var hasActiveSearch: Bool {
        !searchText.isEmpty
    }
    
    var hasActiveFilters: Bool {
        selectedCategory != .all || hasActiveSearch
    }
    
    var isEmptyState: Bool {
        !isLoading && !hasEvents && errorMessage == nil
    }
    
    var isEmptySearchState: Bool {
        !isLoading && hasEvents && !hasFilteredEvents && hasActiveSearch
    }
    
    // MARK: - Init
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    // MARK: - Public Functions
    func fetchEvents() {
        isLoading = true
        errorMessage = nil
        
        let filters = buildFilters()
        let endpoint = EventAPI.getEvents(filters: filters)
        
        Task {
            do {
                let response: EventsResponse = try await networkService.fetch(from: endpoint)
                await MainActor.run {
                    self.events = response.items
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func selectCategory(_ category: EventCategory) {
        selectedCategory = category
        fetchEvents()
    }
    
    func clearSearch() {
        searchText = ""
    }
    
    func resetFilters() {
        selectedCategory = .all
        searchText = ""
        fetchEvents()
    }
    
    func refreshEvents() {
        fetchEvents()
    }
    
    func searchEvents(query: String) {
        searchText = query
    }
    
    func formattedCategory(for event: Event) -> String {
        return event.eventTypeName
    }
    
    func formattedMonth(for event: Event) -> String {
        guard let date = dateFromISO8601(event.startDateTime) else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date).uppercased()
    }
    
    func formattedDay(for event: Event) -> String {
        guard let date = dateFromISO8601(event.startDateTime) else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
    
    func formattedTime(for event: Event) -> String {
        guard let date = dateFromISO8601(event.startDateTime) else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
    
    func formattedLocation(for event: Event) -> String {
        if let venueName = event.venueName, let address = event.address {
            return "\(venueName), \(address)"
        } else if let venueName = event.venueName {
            return venueName
        } else if let address = event.address {
            return address
        } else if let onlineAddress = event.onlineAddress {
            return "Online: \(onlineAddress)"
        } else {
            return "Location TBD"
        }
    }
    
    func formattedRegistered(for event: Event) -> Int {
        return event.confirmedCount
    }
    
    func formattedSpotsLeft(for event: Event) -> Int {
        return max(0, event.capacity - event.confirmedCount)
    }
    
    func formattedStatus(for event: Event) -> String {
        let spotsLeft = formattedSpotsLeft(for: event)
        if event.isFull {
            return "Full"
        } else if spotsLeft <= 5 && spotsLeft > 0 {
            return "Waitlist"
        } else {
            return "Available"
        }
    }
    
    //MARK: - Private Functions
    private func buildFilters() -> [String: Any]? {
        var filters: [String: Any] = [:]
        
        if selectedCategory != .all {
            if let categoryName = apiCategoryName(for: selectedCategory) {
                filters["eventTypeName"] = categoryName
            }
        }
        
        return filters.isEmpty ? nil : filters
    }
    
    private func apiCategoryName(for category: EventCategory) -> String? {
        let categoryMapping: [EventCategory: String] = [
            .teamBuilding: "Team Building",
            .workshop: "Workshop",
            .wellness: "Wellness",
            .sports: "Sports",
            .happyFriday: "Happy Friday",
            .cultural: "Cultural"
        ]
        
        return categoryMapping[category]
    }
    
    //MARK: - RAGACA JADO FORMATTERI
    private func dateFromISO8601(_ dateString: String) -> Date? {
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withTimeZone]
        if let date = formatter.date(from: dateString) {
            return date
        }
        
        let withZ = dateString + "Z"
        if let date = formatter.date(from: withZ) {
            return date
        }
        
        let customFormatter = DateFormatter()
        customFormatter.locale = Locale(identifier: "en_US_POSIX")
        customFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        customFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        if let date = customFormatter.date(from: dateString) {
            return date
        }
        
        customFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let date = customFormatter.date(from: dateString) {
            return date
        }
        
        customFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return customFormatter.date(from: dateString)
    }
}
