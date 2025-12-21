//
//  MainCoordinatorView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

enum MainRoute: Hashable {
    case eventDetails(Int)
}

struct MainCoordinatorView: View {

    @State private var path = NavigationPath()
    @State private var selectedTab: AppTab = .home
    @State private var preselectedCategory: EventCategory? = nil

    let onLogout: () -> Void

    var body: some View {
        NavigationStack(path: $path) {
            MainTabView(
                selectedTab: $selectedTab,
                preselectedCategory: $preselectedCategory,
                onEventSelected: { eventID in
                    path.append(MainRoute.eventDetails(eventID))
                },
                onCategorySelected: { categoryID in
                    preselectedCategory = mapCategory(categoryID)
                    selectedTab = .browse
                },
                onLogout: onLogout
            )
            .navigationDestination(for: MainRoute.self) { route in
                switch route {
                case .eventDetails(let eventID):
                    EventDetailsView(eventId: eventID)
                }
            }
        }
        .onChange(of: selectedTab) { _, _ in
            path = NavigationPath()
        }
    }

    //TODO: - სწორი კატეგორიები ჩაისვას
    private func mapCategory(_ id: Int) -> EventCategory {
        switch id {
        case 1: return .teamBuilding
        case 2: return .workshop
        case 3: return .wellness
        default: return .all
        }
    }
}

