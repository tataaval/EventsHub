//
//  LoginView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

struct LoginView: View {

    let onRegister: () -> Void
    let onResetPassword: () -> Void
    let onLoginSuccess: () -> Void

    var body: some View {
        VStack {
            Button("Sign In", action: onLoginSuccess)
            Button("Register", action: onRegister)
            Button("Forgot Password", action: onResetPassword)
        }
    }
}
