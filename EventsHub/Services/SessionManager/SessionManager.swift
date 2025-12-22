//
//  SessionManager.swift
//  EventsHub
//
//  Created by Tatarella on 22.12.25.
//


import Combine

final class SessionManager: ObservableObject {

    static let shared = SessionManager()

    enum State {
        case authenticated
        case unauthenticated
    }

    @Published private(set) var state: State

    private init() {
        state = TokenManager.shared.getToken() == nil
            ? .unauthenticated
            : .authenticated
    }

    func login(token: String) {
        TokenManager.shared.save(token: token)
        state = .authenticated
    }

    func logout() {
        TokenManager.shared.clear()
        state = .unauthenticated
    }
}
