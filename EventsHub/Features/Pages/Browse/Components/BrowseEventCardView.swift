//
//  BrowseEventCardView.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct BrowseEventCardView: View {

    let event: Event
    let onEventSelected: (Int) -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            dateView

            VStack(alignment: .leading, spacing: 6) {

                HStack {
                    Text(event.category)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.gray100).opacity(0.3))
                        .cornerRadius(8)

                    Spacer()

                    Text(event.status)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.gray100).opacity(0.3))
                        .cornerRadius(8)
                }

                Text(event.title)
                    .font(.system(size: 16))

                Label(event.time, systemImage: "clock")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)

                Label(event.location, systemImage: "location")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)

                HStack(spacing: 12) {
                    Label(
                        "\(event.registered) registered",
                        systemImage: "person.2"
                    )
                    .font(.system(size: 12))
                    .foregroundStyle(.gray500)
                    Label("\(event.spotsLeft) spots left", systemImage: "chair")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray500)
                }
                .font(.caption2)
                .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .onTapGesture {
            onEventSelected(event.id)
        }
    }

    private var dateView: some View {
        VStack {
            Text(event.month)
                .font(.system(size: 12))
                .foregroundStyle(.gray300)
            Text(event.day)
                .font(.system(size: 24))
                .foregroundStyle(.gray900)
        }
    }
}
