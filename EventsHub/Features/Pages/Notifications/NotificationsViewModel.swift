import Foundation
import Combine

final class NotificationsViewModel: ObservableObject {
    //MARK: - Properties
    @Published var notifications: [Notifications] = []
    @Published var selectedType: NotificationsType = .all
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    
    //MARK: - Computed Properties
    var filteredNotifications: [Notifications] {
        if selectedType == .all {
            return notifications
        }
        return notifications.filter { $0.type == selectedType }
    }
    
    var newNotifications: [Notifications] {
        filteredNotifications.filter { $0.status == .new }
    }
    
    var earlierNotifications: [Notifications] {
        filteredNotifications.filter { $0.status == .earlier }
    }
    
    //MARK: - Init
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    //MARK: - Public Functions
    func fetchNotifications() {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        let endpoint = EventAPI.notifications
        
        do {
            let _ = try endpoint.urlRequest()
        } catch {
        }
        
        Task {
            do {
                let apiNotifications: [Notification] = try await networkService.fetch(from: endpoint)
                await MainActor.run {
                    self.notifications = apiNotifications.map { self.mapToUINotification($0) }
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    let errorMessage: String
                    if let networkError = error as? NetworkError {
                        switch networkError {
                        case .clientError(let code, let message):
                            errorMessage = message ?? "Error \(code): Failed to fetch notifications"
                        case .serverError(let code, let message):
                            errorMessage = message ?? "Server error \(code): Please try again later"
                        case .decodingFailed:
                            errorMessage = "Failed to process notifications data"
                        case .invalidResponse:
                            errorMessage = "Invalid response from server"
                        case .unknownError(let code):
                            errorMessage = "Unexpected error: \(code)"
                        }
                    } else {
                        errorMessage = error.localizedDescription
                    }
                    
                    self.errorMessage = errorMessage
                    self.isLoading = false

                }
            }
        }
    }
    
    func selectType(_ type: NotificationsType) {
        selectedType = type
    }
    
    //MARK: - Private Functions
    private func mapToUINotification(_ apiNotification: Notification) -> Notifications {
        return Notifications(
            id: UUID(),
            type: mapNotificationType(apiNotification.notificationType),
            status: mapNotificationStatus(apiNotification.status),
            title: apiNotification.message,
            workshopTitle: extractEventTitle(from: apiNotification.message),
            timeline: formatTimeline(from: apiNotification.sentAt),
            eventTime: "",
            location: "",
            isUnread: apiNotification.status.lowercased() != "read"
        )
    }
    
    private func mapNotificationType(_ type: String) -> NotificationsType {
        let lowercased = type.lowercased()
        if lowercased.contains("registration") {
            return .registrations
        } else if lowercased.contains("reminder") {
            return .reminders
        } else if lowercased.contains("update") {
            return .updates
        }
        return .all
    }
    
    private func mapNotificationStatus(_ status: String) -> NotificationStatus {
        let lowercased = status.lowercased()
        if lowercased == "sent" || lowercased == "new" || lowercased == "unread" {
            return .new
        }
        return .earlier
    }
    
    private func extractEventTitle(from message: String) -> String {
        let components = message.components(separatedBy: ":")
        if components.count > 1 {
            let afterColon = components[1].trimmingCharacters(in: .whitespaces)
            let forComponents = afterColon.components(separatedBy: " for ")
            if forComponents.count > 1 {
                return forComponents[1].trimmingCharacters(in: .whitespaces)
            }
            return afterColon
        }
        return message
    }
    
    private func formatTimeline(from dateString: String) -> String {
        guard let date = dateFromISO8601(dateString) else {
            return ""
        }
        
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour, .day], from: date, to: now)
        
        if let minutes = components.minute, minutes < 60 {
            return minutes <= 1 ? "Just now" : "\(minutes) minutes ago"
        } else if let hours = components.hour, hours < 24 {
            return hours == 1 ? "1 hour ago" : "\(hours) hours ago"
        } else if let days = components.day {
            if days == 1 {
                return "Yesterday"
            } else if days < 7 {
                return "\(days) days ago"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, yyyy"
                return formatter.string(from: date)
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    //MARK: - RAGAC JADO FORMATTER
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
