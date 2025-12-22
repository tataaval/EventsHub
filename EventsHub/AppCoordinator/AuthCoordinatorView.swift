//
//  AuthCoordinatorView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//

import SwiftUI

enum AuthRoute: Hashable {
    case register
    case resetPassword
}

struct AuthCoordinatorView: View {

    @State private var path: [AuthRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            LoginView(
                onRegister: { path.append(.register) },
                onResetPassword: { path.append(.resetPassword) },
            )
            .navigationDestination(for: AuthRoute.self) { route in
                switch route {
                case .register:
                    RegisterView(
                        onLogin: {
                            path.removeAll()
                        }
                    )

                case .resetPassword:
                    ResetPasswordView(
                        text: .constant(""),
                        onBackToLogin: {
                            path.removeAll()
                        }
                    )

                }
            }
        }
    }
}
