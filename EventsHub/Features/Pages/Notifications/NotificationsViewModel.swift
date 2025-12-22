import Foundation
import Combine

class NotificationsViewModel: ObservableObject {
    @Published var notifications: [Notifications] = []
    @Published var selectedType: NotificationsType = .all
    
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
    
    init() {
        loadNotifications()
    }
    
    func selectType(_ type: NotificationsType) {
        selectedType = type
    }
    
    private func loadNotifications() {
        notifications = [
            Notifications(
                type: .registrations,
                status: .new,
                title: "Registration Confirmed: You are now registered for the Leadership Workshop",
                workshopTitle: "Leadership Workshop",
                timeline: "15 minutes ago",
                eventTime: "Jan 26, 2025, 11:00 AM - 12:30 PM",
                location: "Virtual Meeting",
                isUnread: true
            ),
            Notifications(
                type: .reminders,
                status: .new,
                title: "Event Reminder: Team Building Summit starts in 24 hours",
                workshopTitle: "Team Building Summit",
                timeline: "1 hour ago",
                eventTime: "Jan 27, 2025, 10:00 AM - 5:00 PM",
                location: "Tbilisi Art Gallery",
                isUnread: true
            ),
            Notifications(
                type: .updates,
                status: .earlier,
                title: "Event Update: The location for Game Night has been changed",
                workshopTitle: "Game Night",
                timeline: "Yesterday",
                eventTime: "Jan 28, 2025, 7:00 PM - 10:00 PM",
                location: "Recreation Lounge",
                isUnread: false
            ),
            Notifications(
                type: .registrations,
                status: .earlier,
                title: "Registration Confirmed: You're signed up for AI Business Talk",
                workshopTitle: "AI Business Talk",
                timeline: "2 days ago",
                eventTime: "Jan 22, 2025, 2:00 PM - 3:30 PM",
                location: "Tech Hub",
                isUnread: false
            ),
            Notifications(
                type: .reminders,
                status: .earlier,
                title: "Event Reminder: Quarterly All-Hands Meeting starts soon",
                workshopTitle: "Quarterly All-Hands Meeting",
                timeline: "3 days ago",
                eventTime: "Jan 20, 2025, 11:00 AM - 12:00 PM",
                location: "Main Conference Hall",
                isUnread: false
            )
        ]
    }
}
