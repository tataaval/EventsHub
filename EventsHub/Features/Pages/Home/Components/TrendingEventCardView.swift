//
//  TrendingEventCardView.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//

import SwiftUI

struct TrendingEventCardView: View {
    //MARK: - properties
    let event: EventModel
    let onEventSelected: (Int) -> Void
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(height: 120)
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(.system(size: 16))
                    .foregroundColor(.gray900)
                
                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Image(systemName: "calendar")
                        Text("\(event.monthString) \(event.yearString), \(event.yearString)")
                    }
                    .font(.system(size: 12))
                    .foregroundStyle(.gray300)
                }
            }
            .padding()
        }
        .background(.white)
        .cornerRadius(8)
        .frame(width: 240)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .onTapGesture {
            onEventSelected(event.id)
        }
    }
}
