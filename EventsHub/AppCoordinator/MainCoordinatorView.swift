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

    var body: some View {
        NavigationStack(path: $path) {
            MainTabView(
                selectedTab: $selectedTab,
                preselectedCategory: $preselectedCategory,
                onEventSelected: { eventID in
                    path.append(MainRoute.eventDetails(eventID))
                },
                onCategorySelected: { categoryName in
                    preselectedCategory = mapCategory(categoryName)
                    selectedTab = .browse
                }
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

    private func mapCategory(_ id: String) -> EventCategory {
        switch id {
        case "Team Building": return .teamBuilding
        case "Workshop": return .workshop
        case "Wellness": return .wellness
        case "Sports": return .sports
        case "Happy Friday": return .happyFriday
        case "Cultural": return .cultural
        default: return .all
        }
    }
}
