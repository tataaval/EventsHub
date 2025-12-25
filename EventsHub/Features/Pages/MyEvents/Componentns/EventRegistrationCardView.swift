//
//  EventRegistrationCardView.swift
//  EventsHub
//
//  Created by Tatarella on 25.12.25.
//

import SwiftUI

struct EventRegistrationCardView: View {

    let registration: EventRegistration

    var body: some View {
        HStack(alignment: .top, spacing: 16) {

            VStack(spacing: 4) {
                Text(registration.timeString)
                    .font(.system(size: 18))
                    .foregroundColor(.gray900)

                Text(registration.monthString.uppercased())
                    .font(.system(size: 12))
                    .foregroundColor(.gray300)
            }

            Rectangle()
                .fill(.gray100)
                .frame(width: 2)

            VStack(alignment: .leading, spacing: 8) {

                Text(registration.eventTitle)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray300)
                    .lineLimit(2)
                
                HStack(spacing: 6) {
                    Image(registration.eventType.snakeCased)
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text(registration.eventType)
                }
                .font(.system(size: 12))
                .foregroundStyle(.gray300)

                Label(locationText, systemImage: "mappin.and.ellipse")
                    .font(.system(size: 12))
                    .foregroundColor(.gray300)
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }

    private var locationText: String {
        registration.onlineAddress ?? registration.normalizedVenueName
    }
}
