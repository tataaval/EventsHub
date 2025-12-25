import Foundation
import Combine

final class NotificationsViewModel: ObservableObject {
    //MARK: - Properties
    @Published var notifications: [Notifications] = []
    @Published var selectedType: NotificationsType = .all
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    private var readNotificationIds: Set<Int> = []
    
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
                    for apiNotification in apiNotifications {
                        if apiNotification.status.lowercased() == "read" {
                            self.readNotificationIds.insert(apiNotification.id)
                        }
                    }
                    
                    self.notifications = apiNotifications.map { apiNotification in
                        let isRead = self.readNotificationIds.contains(apiNotification.id) || 
                                    apiNotification.status.lowercased() == "read"
                        return self.mapToUINotification(apiNotification, isRead: isRead)
                    }
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
    
    func markAsRead(_ notification: Notifications) {
        Task {
            do {
                let endpoint = EventAPI.markNotificationAsRead(id: notification.apiId)
                let response: EmptyResponse = try await networkService.fetch(from: endpoint)
                
                await MainActor.run {
                    self.readNotificationIds.insert(notification.apiId)
                    
                    if let index = self.notifications.firstIndex(where: { $0.id == notification.id }) {
                        let currentNotification = self.notifications[index]
                        let updated = Notifications(
                            id: currentNotification.id,
                            apiId: currentNotification.apiId,
                            type: currentNotification.type,
                            status: .earlier,
                            title: currentNotification.title,
                            workshopTitle: currentNotification.workshopTitle,
                            timeline: currentNotification.timeline,
                            eventTime: currentNotification.eventTime,
                            location: currentNotification.location,
                            isUnread: false
                        )
                        self.notifications[index] = updated
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - Private Functions
    private func mapToUINotification(_ apiNotification: Notification, isRead: Bool? = nil) -> Notifications {
        let readStatus = isRead ?? (apiNotification.status.lowercased() == "read")
        let notificationStatus = readStatus ? NotificationStatus.earlier : mapNotificationStatus(apiNotification.status)
        
        return Notifications(
            id: UUID(),
            apiId: apiNotification.id,
            type: mapNotificationType(apiNotification.notificationType),
            status: notificationStatus,
            title: apiNotification.message,
            workshopTitle: extractEventTitle(from: apiNotification.message),
            timeline: formatTimeline(from: apiNotification.sentAt),
            eventTime: "",
            location: "",
            isUnread: !readStatus
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
