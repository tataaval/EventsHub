//
//  WelcomeView.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct WelcomeView: View {
    //MARK: - properties
    let userName: String

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Welcome back, \(userName)")
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(.gray900)

            Text("Stay connected with upcoming company events and activities.")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.gray300)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
