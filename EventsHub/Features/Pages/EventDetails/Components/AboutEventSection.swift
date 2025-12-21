//
//  AboutEventSection.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct AboutEventSection: View {

    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About this event")
                .font(.system(size: 18))

            Text(description)
                .font(.system(size: 14))
                .foregroundColor(.gray300)
        }
        .padding(.horizontal)
    }
}
