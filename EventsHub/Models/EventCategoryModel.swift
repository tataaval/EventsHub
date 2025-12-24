//
//  EventCategoryModel.swift
//  EventsHub
//
//  Created by Tatarella on 24.12.25.
//


struct EventCategoryModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let eventCount: Int
}
