//
//  EventCardView.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct EventCardView: View {
    //MARK: - properties
    let event: UpcomingEvent
    let onEventSelected: (Int) -> Void

    //MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            VStack {
                Text(event.date.prefix(3))
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)

                Text(event.date.suffix(2))
                    .font(.system(size: 24))
                    .foregroundStyle(.gray900)
            }


            VStack(alignment: .leading, spacing: 10) {
                Text(event.title)
                    .font(.system(size: 16))
                    .foregroundStyle(.gray900)

                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Image(systemName: "clock")
                        Text(event.time)
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "map")
                        Text(event.location)
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)
                }

                Text(event.description)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray500)

                HStack(spacing: 4) {
                    HStack(spacing: 2) {
                        Image(systemName: "person.3")
                        Text(event.registered)
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)
                    
                    HStack(spacing: 2) {
                        Circle()
                            .fill(.gray300)
                            .frame(width: 4, height: 4)
                        Text(event.spotsLeft)
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)

                    Button {
                        onEventSelected(event.id)
                    } label: {
                        HStack(spacing: 4) {
                            Text("View Details")
                                .font(.system(size: 14))
                                .foregroundStyle(.gray900)

                            Image(systemName: "arrow.right")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray900)
                        }
                    }

                }
            }
        }
        .padding(14)
        .background(.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
