//
//  EventCardView.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct EventCardView: View {
    //MARK: - properties
    let event: EventModel
    let onEventSelected: (Int) -> Void

    //MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            VStack {
                Text(event.monthString)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)

                Text(event.dayString)
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
                        Text(event.timeString)
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "map")
                        Text(event.isOnline ? "Online" : event.normalizedVenueName)
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)
                }

                if let description = event.description{
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundStyle(.gray500)
                        .lineLimit(2)
                }

                HStack(spacing: 4) {
                    HStack(spacing: 2) {
                        Image(systemName: "person.3")
                        Text("\(event.confirmedCount) registered")
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)
                    
                    HStack(spacing: 2) {
                        Circle()
                            .fill(.gray300)
                            .frame(width: 4, height: 4)
                        if event.isFull {
                            Text("Full")
                        } else {
                            Text("\(event.availableSpots) left")
                        }
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)
                    Spacer()
                    Button {
                        onEventSelected(event.id)
                    } label: {
                        HStack(spacing: 4) {
                            Text("View Details")
                                .font(.system(size: 14, weight: .semibold))
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
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
