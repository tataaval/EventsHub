import Foundation

struct Event: Decodable, Identifiable {
    let id: Int
    let title: String
    let eventTypeName: String
    let startDateTime: String
    let venueName: String?
    let address: String?
    let onlineAddress: String?
    let capacity: Int
    let confirmedCount: Int
    let isFull: Bool
    let imageUrl: String?
    let tags: [String]
}

