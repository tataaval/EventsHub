//
//  EventDetailRow.swift.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct EventDetailRow: View {

    //MARK: - properties
    let icon: String
    let text: String

    //MARK: - Body
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.system(size: 12))
        .foregroundStyle(.gray300)
    }
}
