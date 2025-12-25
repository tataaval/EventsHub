//
//  SessionManager.swift
//  EventsHub
//
//  Created by Tatarella on 22.12.25.
//


import Combine

@MainActor
final class SessionManager: ObservableObject {

    static let shared = SessionManager()

    enum State {
        case authenticated
        case unauthenticated
    }

    @Published private(set) var state: State
    @Published private(set) var profile: UserProfile?

    private init() {
        let tokenExists = TokenManager.shared.getToken() != nil
        let storedProfile = ProfileStorage.shared.getProfile()

        self.profile = storedProfile
        self.state = tokenExists && storedProfile != nil
            ? .authenticated
            : .unauthenticated
    }

    func login(token: String, profile: UserProfile) {
        TokenManager.shared.save(token: token)
        ProfileStorage.shared.save(profile: profile)

        self.profile = profile
        self.state = .authenticated
    }

    func logout() {
        TokenManager.shared.clear()
        ProfileStorage.shared.clear()

        profile = nil
        state = .unauthenticated
    }
}

