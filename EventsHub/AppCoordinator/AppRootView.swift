//
//  AppRootView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//


import SwiftUI

struct AppRootView: View {

    @EnvironmentObject private var appCoordinator: AppCoordinator

    var body: some View {
        switch appCoordinator.flow {

        case .auth:
            AuthCoordinatorView()

        case .main:
            MainCoordinatorView()
        }
    }
}
