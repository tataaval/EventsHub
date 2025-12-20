//
//  MainTabView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

struct MainTabView: View {

    let onEventSelected: (Int) -> Void
    let onCategorySelected: (Int) -> Void
    let onLogout: () -> Void

    var body: some View {
        TabView {

            HomeView(
                onEventSelected: onEventSelected,
                onCategorySelected: onCategorySelected
            )
            .tabItem {
                Label("Home", systemImage: "house")
            }

            BrowseView(
                onEventSelected: onEventSelected
            )
            .tabItem {
                Label("Browse", systemImage: "magnifyingglass")
            }

            MyEventsView(
                onEventSelected: onEventSelected
            )
            .tabItem {
                Label("My Events", systemImage: "calendar")
            }

            NotificationsView()
            .tabItem {
                Label("Notifications", systemImage: "bell")
            }

            ProfileView(
                onLogout: onLogout
            )
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
    }
}
