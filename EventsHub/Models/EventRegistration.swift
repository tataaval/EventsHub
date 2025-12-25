//
//  EventRegistration.swift
//  EventsHub
//
//  Created by Tatarella on 25.12.25.
//
import Foundation

struct EventRegistration: Decodable, Identifiable {
    let id: Int
    let eventId: Int
    let eventTitle: String
    let eventType: String
    let startDateTime: Date
    let venueName: String?
    let address: String?
    let onlineAddress: String?
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id = "registrationId"
        case eventId
        case eventTitle
        case eventType
        case startDateTime
        case venueName
        case address
        case onlineAddress
        case status
    }

}

extension EventRegistration {
    
    var normalizedVenueName: String {
        venueName ?? "No Venue Info"
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

}
