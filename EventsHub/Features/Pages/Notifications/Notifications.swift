import Foundation

struct Notifications: Identifiable {
    let id: UUID
    let type: NotificationsType
    let status: NotificationStatus
    let title: String
    let workshopTitle: String
    let timeline: String
    let eventTime: String
    let location: String
    let isUnread: Bool
    
    var iconName: String {
        type.systemImage
    }
}
