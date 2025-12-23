//
//  ProfileStorage.swift
//  EventsHub
//
//  Created by Tatarella on 23.12.25.
//
import Foundation

final class ProfileStorage {

    static let shared = ProfileStorage()
    private init() {}

    private let key = "user_profile"

    func save(profile: UserProfile) {
        let data = try? JSONEncoder().encode(profile)
        UserDefaults.standard.set(data, forKey: key)
    }

    func getProfile() -> UserProfile? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(UserProfile.self, from: data)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
