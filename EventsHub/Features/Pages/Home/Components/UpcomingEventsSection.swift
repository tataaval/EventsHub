//
//  UpcomingEventsSection.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct UpcomingEventsSection: View {
    //MARK: - properties
    let events: [UpcomingEvent]
    let onEventSelected: (Int) -> Void
    let onViewAllTapped: () -> Void

    //MARK: - body
    var body: some View {
        VStack(spacing: 16) {

            HStack {
                Text("Upcoming Events")
                    .font(.system(size: 18))
                    .foregroundStyle(.gray900)

                Spacer()

                Button(action: onViewAllTapped) {
                    Text("View all")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray500)
                }
            }
            LazyVStack {
                ForEach(events) { event in
                    EventCardView(
                        event: event,
                        onEventSelected: onEventSelected
                    )
                }
            }

        }
    }
}
