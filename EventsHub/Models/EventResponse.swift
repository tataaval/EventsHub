//
//  EventResponse.swift
//  EventsHub
//
//  Created by Tatarella on 24.12.25.
//

import Foundation

struct EventResponse: Decodable {
    let items: [EventModel]
    let totalCount: Int
    let totalPages: Int
    let currentPage: Int
    let pageSize: Int
    let hasPrevious: Bool
    let hasNext: Bool
}
