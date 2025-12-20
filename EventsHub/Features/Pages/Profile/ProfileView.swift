//
//  ProfileView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//

import SwiftUI

struct ProfileView: View {

    let onLogout: () -> Void

    var body: some View {
        VStack {
            Button("logout", action: onLogout)
        }
    }
}
