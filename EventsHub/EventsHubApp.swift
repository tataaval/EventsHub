//
//  EventsHubApp.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//

import SwiftUI

@main
struct EventsHubApp: App {
    @StateObject private var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(appCoordinator)
        }
    }
}
