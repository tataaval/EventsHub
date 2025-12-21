//
//  BrowseViewModel.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//

import Combine

final class BrowseViewModel: ObservableObject {
    
    @Published var selectedCategory: EventCategory = .all
    @Published var events: [Event] = [
        Event(
            id: 1, 
            title: "Annual Team Building Summit",
            category: "Team Building",
            month: "JAN",
            day: "18",
            time: "09:00 AM - 05:00 PM",
            location: "Grand Conference Hall",
            registered: 142,
            spotsLeft: 8,
            status: "Available"
        ),
        Event(
            id: 2,
            title: "Leadership Workshop",
            category: "Workshop",
            month: "JAN",
            day: "20",
            time: "02:00 PM - 04:30 PM",
            location: "Training Room B",
            registered: 28,
            spotsLeft: 2,
            status: "Waitlist"
        ),
        Event(
            id: 3, 
            title: "Leadership Workshop",
            category: "Workshop",
            month: "JAN",
            day: "20",
            time: "02:00 PM - 04:30 PM",
            location: "Training Room B",
            registered: 28,
            spotsLeft: 0,
            status: "Full"
        )
    ]

}
