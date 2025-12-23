//
//  MainTabView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

enum AppTab: Hashable {
    case home
    case browse
    case myEvents
    case notifications
    case profile
}

struct MainTabView: View {

    @Binding var selectedTab: AppTab
    @Binding var preselectedCategory: EventCategory?

    let onEventSelected: (Int) -> Void
    let onCategorySelected: (Int) -> Void

    var body: some View {
        TabView(selection: $selectedTab) {

            HomeView(
                onEventSelected: onEventSelected,
                onCategorySelected: onCategorySelected,
                onViewAllTapped: {
                    selectedTab = .browse
                }
            )
            .tabItem { Label("Home", systemImage: "house") }
            .tag(AppTab.home)

            BrowseView(
                preselectedCategory: $preselectedCategory,
                onEventSelected: onEventSelected
            )
            .tabItem { Label("Browse", systemImage: "magnifyingglass") }
            .tag(AppTab.browse)

            MyEventsView(onEventSelected: onEventSelected)
                .tabItem { Label("My Events", systemImage: "calendar") }
                .tag(AppTab.myEvents)

            NotificationsView(viewModel: NotificationsViewModel())
                .tabItem { Label("Notifications", systemImage: "bell") }
                .tag(AppTab.notifications)

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
                .tag(AppTab.profile)
        }
    }
}

