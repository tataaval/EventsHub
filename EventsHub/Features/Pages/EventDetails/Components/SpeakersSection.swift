//
//  SpeakersSection.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct SpeakersSection: View {

    let speakers: [Speaker]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Featured Speakers")
                .font(.system(size: 18))

            ForEach(speakers) { speaker in
                HStack(spacing: 12) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 56, height: 56)
                        .foregroundColor(.gray300)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(speaker.name)
                            .font(.system(size: 16))
                            .foregroundStyle(.gray900)

                        Text(speaker.role)
                            .font(.system(size: 14))
                            .foregroundStyle(.gray300)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
