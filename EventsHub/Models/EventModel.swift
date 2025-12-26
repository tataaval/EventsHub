//
//  EventModel.swift
//  EventsHub
//
//  Created by Tatarella on 24.12.25.
//
import Foundation

struct EventModel: Decodable, Identifiable {
    let id: Int
    let title: String
    let eventTypeName: String
    let description: String?
    let startDateTime: Date
    let venueName: String?
    let address: String?
    let onlineAddress: String?
    let capacity: Int
    let confirmedCount: Int
    let isFull: Bool
    let imageUrl: String?
    let tags: [String]
}

extension EventModel {
    
    var normalizedVenueName: String {
        venueName ?? "No Venue Info"
    }

    var availableSpots: Int {
        max(capacity - confirmedCount, 0)
    }

    var isOnline: Bool {
        onlineAddress != nil
    }

    var dayString: String {
        startDateTime.formatted(.dateTime.day())
    }

    var monthString: String {
        startDateTime.formatted(.dateTime.month(.abbreviated))
    }

    var timeString: String {
        startDateTime.formatted(.dateTime.hour().minute())
    }

    var yearString: String {
        startDateTime.formatted(.dateTime.year())
    }
    
    var dateText: String {
        "\(monthString) \(dayString), \(yearString)"
    }
    
    var imageUrlNormalized: String {
        imageUrl ?? ""
    }

}
