//
//  TrendingEventsSection.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct TrendingEventsSection: View {
    //MARK: - properties
    let trendingEvents: [EventModel]
    let onEventSelected: (Int) -> Void
    
    //MARK: - body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Trending Events")
                .font(.system(size: 18))
                .foregroundStyle(.gray900)
            
            Text("Popular events with high registration rates.")
                .font(.system(size: 14))
                .foregroundStyle(.gray300)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(trendingEvents) { event in
                        TrendingEventCardView(
                            event: event,
                            onEventSelected: onEventSelected
                        )
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}
