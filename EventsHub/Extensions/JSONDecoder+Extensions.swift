//
//  JSONDecoder+Extensions.swift
//  EventsHub
//
//  Created by Tatarella on 24.12.25.
//
import Foundation

extension JSONDecoder {
    static let eventDecoder: JSONDecoder = {
        let decoder = JSONDecoder()

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"

        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
}
