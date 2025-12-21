//
//  EventInfoSection.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct EventInfoSection: View {

    let event: EventDetailsModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text(event.title)
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(.gray900)

            EventDetailRow(icon: "calendar", text: event.date)
            EventDetailRow(icon: "clock", text: event.time)
            EventDetailRow(icon: "mappin.and.ellipse", text: event.location)
            EventDetailRow(icon: "person.2", text: event.registrationInfo)
        }
        .padding(.horizontal)
    }
}
