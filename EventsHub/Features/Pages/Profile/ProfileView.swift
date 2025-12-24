//
//  ProfileView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//

import SwiftUI

struct ProfileView: View {

    //TODO: - სხვანაირად ჯობია
    @ObservedObject private var session = SessionManager.shared

    var body: some View {
        VStack(spacing: 24) {

            if let profile = session.profile {

                VStack(spacing: 8) {
                    Text(profile.fullName)
                        .font(.system(size: 22, weight: .semibold))

                    Text(profile.role)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
            }
            Button {
                session.logout()
            } label: {
                Text("Log out")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 1)
                    )
            }
        }
        .padding()
    }
}
