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

    let onEventSelected: (Int) -> Void
    let onCategorySelected: (Int) -> Void
    let onLogout: () -> Void
    
    @State private var selectedTab: AppTab = .home

    var body: some View {
        TabView(selection: $selectedTab) {

            HomeView(
                onEventSelected: onEventSelected,
                onCategorySelected: onCategorySelected,
                onViewAllTapped: {
                    selectedTab = .browse
                }
            )
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(AppTab.home)

            BrowseView(
                onEventSelected: onEventSelected
            )
            .tabItem {
                Label("Browse", systemImage: "magnifyingglass")
            }
            .tag(AppTab.browse)

            MyEventsView(
                onEventSelected: onEventSelected
            )
            .tabItem {
                Label("My Events", systemImage: "calendar")
            }
            .tag(AppTab.myEvents)

            NotificationsView()
            .tabItem {
                Label("Notifications", systemImage: "bell")
            }
            .tag(AppTab.notifications)

            ProfileView(
                onLogout: onLogout
            )
            .tabItem {
                Label("Profile", systemImage: "person")
            }
            .tag(AppTab.profile)
        }
    }
}
