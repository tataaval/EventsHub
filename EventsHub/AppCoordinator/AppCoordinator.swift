//
//  AppCoordinator.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//

import Combine
import Foundation

@MainActor
final class AppCoordinator: ObservableObject {

    enum Flow {
        case auth
        case main
    }

    @Published var flow: Flow = .auth
    private var cancellables = Set<AnyCancellable>()

    init() {
        flow = (SessionManager.shared.state == .authenticated) ? .main : .auth

        SessionManager.shared.$state
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.flow = (state == .authenticated) ? .main : .auth
            }
            .store(in: &cancellables)
    }

    func logout() {
        SessionManager.shared.logout()
    }
}

