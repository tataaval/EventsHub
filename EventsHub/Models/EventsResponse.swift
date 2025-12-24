import Foundation

struct EventsResponse: Decodable {
    let items: [Event]
    let totalCount: Int
    let totalPages: Int
    let currentPage: Int
    let pageSize: Int
    let hasPrevious: Bool
    let hasNext: Bool
}
