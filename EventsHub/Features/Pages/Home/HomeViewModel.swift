//
//  HomeViewModel.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//

import Combine


final class HomeViewModel: ObservableObject {
    //temporary data
    @Published var categories: [Category] = [
        Category(id: 1, title: "Team Building", icon: "person.3", eventCount: 12),
        Category(id: 2, title: "Sports", icon: "figure.run", eventCount: 8),
        Category(id: 3, title: "Sports", icon: "figure.run", eventCount: 8),
        Category(id: 4, title: "Sports", icon: "figure.run", eventCount: 8),
        Category(id: 5, title: "Sports", icon: "figure.run", eventCount: 8),
        
    ]
    
    @Published var  trendingEvents: [TrendingEvent] = [
        TrendingEvent(id: 1, title: "Tech Talk: AI in Business", date: " Jan 26, 2025"),
        TrendingEvent(id: 2, title: "Tech Talk: AI in Business", date: " Jan 26, 2025"),
        TrendingEvent(id: 3, title: "Tech Talk: AI in Business", date: " Jan 26, 2025"),
        TrendingEvent(id: 4, title: "Tech Talk: AI in Business", date: " Jan 26, 2025"),
        
    ]
    
    @Published var  upcomingEvents: [UpcomingEvent] = [
        UpcomingEvent(id: 1,
                      date: "JAN 18",
                      title: "Annual Team Building Summit",
                      time: "08:00 AM - 05:00 PM",
                      location: "Grand Conference",
                      description:
                          "Join us for a full day of engaging activities and networking opportunities.",
                      registered: "102 registered", spotsLeft: "8 spots left")
        
    ]
}
