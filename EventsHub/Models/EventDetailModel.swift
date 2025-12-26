//
//  EventDetailModel.swift
//  EventsHub
//
//  Created by Tatarella on 25.12.25.
//

import Foundation

struct EventDetailModel: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let eventTypeName: String
    let startDateTime: Date
    let endDateTime: Date
    let registrationDeadline: Date
    let venueName: String?
    let address: String?
    let onlineAddress: String?
    let capacity: Int
    let confirmedCount: Int
    let waitlistedCount: Int
    let isFull: Bool
    let imageUrl: String?
    let tags: [String]
    let createdBy: String
}

extension EventDetailModel {

    var venueNameNormalized: String {
        venueName ?? "No Data"
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

    var monthStringWide: String {
        startDateTime.formatted(.dateTime.month(.wide))
    }

    var monthStringAbbreviated: String {
        startDateTime.formatted(.dateTime.month(.abbreviated))
    }

    var startTimeString: String {
        startDateTime.formatted(.dateTime.hour().minute())
    }

    var endTimeString: String {
        startDateTime.formatted(.dateTime.hour().minute())
    }

    var yearString: String {
        startDateTime.formatted(.dateTime.year())
    }

    var dateText: String {
        "\(monthStringWide) \(dayString), \(yearString)"
    }

    var locationText: String {
        if isOnline {
            return "Online"
        }
        return venueName ?? "No Data"
    }

    var registrationInfoText: String {
        if isFull {
            return "Full"
        }
        return "Registered \(confirmedCount), \(availableSpots) left"
    }

    var registrationDeadlineText: String {
        let date = registrationDeadline.formatted(.dateTime.month(.abbreviated).day().year())
        let time = registrationDeadline.formatted(.dateTime.hour().minute())
        return "Registration closes on \(date) at \(time)"
    }
    
    var imageUrlNormalized: String {
        imageUrl ?? ""
    }
}
