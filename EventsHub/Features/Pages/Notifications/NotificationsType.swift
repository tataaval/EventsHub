import Foundation

enum NotificationsType: String, CaseIterable, Identifiable {
    case all = "All"
    case registrations = "Registrations"
    case reminders = "Reminders"
    case updates = "Updates"
    
    var systemImage: String {
        switch self {
        case .all: return "list.bullet"
        case .registrations: return "calendar.badge.checkmark"
        case .reminders: return "bell.fill"
        case .updates: return "info.circle.fill"
        }
    }
    var id: String { rawValue }
}
