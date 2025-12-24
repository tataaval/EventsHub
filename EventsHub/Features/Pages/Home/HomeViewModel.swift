//
//  HomeViewModel.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {

    //MARK: - published properties
    @Published var username: String = ""
    @Published var categories: [EventCategoryModel] = []
    @Published var trendingEvents: [EventModel] = []
    @Published var upcomingEvents: [EventModel] = []

    //MARK: - provate properties
    private let session: SessionManager

    //MARK: - init
    init(session: SessionManager = .shared) {
        self.session = session
        bindSession()
        fetchUcomingEvents()
        fetchCategories()
        fetchTrendingEvents()
    }

    //MARK: - provate methods
    private func bindSession() {
        username = session.profile?.fullName ?? ""

        session.$profile
            .map { $0?.fullName ?? "" }
            .assign(to: &$username)
    }
    
    private func fetchUcomingEvents() {
        Task {
            do {
                let response: EventResponse = try await NetworkService.shared.fetch(from: EventAPI.getEvents(filters: ["pageSize": "4"]))
                upcomingEvents = response.items
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchCategories() {
        Task {
            do {
                categories = try await NetworkService.shared.fetch(from: EventAPI.getEventTypes)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchTrendingEvents() {
        Task {
            do {
                trendingEvents = try await NetworkService.shared.fetch(from: EventAPI.getTrendingEvents)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
