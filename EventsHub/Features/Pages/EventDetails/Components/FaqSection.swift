//
//  FaqSection.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct FaqSection: View {

    let items: [Faq]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Frequently Asked Questions")
                .font(.system(size: 18))
                .foregroundStyle(.gray900)

            ForEach(items) { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.question)
                        .font(.system(size: 14))
                        .foregroundColor(.gray900)

                    Text(item.answer)
                        .font(.system(size: 14))
                        .foregroundColor(.gray300)
                }
            }
        }
        .padding(.horizontal)
    }
}
