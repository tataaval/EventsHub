//
//  AppCoordinator.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//

import Combine

enum AppFlow {
    case auth
    case main
}

final class AppCoordinator: ObservableObject {
    @Published var flow: AppFlow = .auth

    func loginSuccess() {
        flow = .main
    }

    func logout() {
        flow = .auth
    }
}
