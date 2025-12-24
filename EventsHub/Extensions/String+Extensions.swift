//
//  String+Extensions.swift
//  EventsHub
//
//  Created by Tatarella on 24.12.25.
//
import Foundation

extension String {

    var lowercasedValue: String {
        self.lowercased()
    }

    var snakeCased: String {
        self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .joined(separator: "_")
    }
}
