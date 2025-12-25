import Foundation

struct Notification: Decodable, Identifiable {
    let id: Int
    let eventId: Int
    let notificationType: String
    let message: String
    let sentAt: String
    let status: String
}

