//
//  RegisterView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

struct RegisterView: View {

    let onLogin: () -> Void

    var body: some View {
        Button("Already have an account? Login", action: onLogin)
    }
}
