//
//  MainCoordinatorView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

enum MainRoute: Hashable {
    case categorizedEvents(Int)
    case eventDetails(Int)
}

struct MainCoordinatorView: View {

    @State private var path: [MainRoute] = []
    let onLogout: () -> Void

    var body: some View {
        NavigationStack(path: $path) {
            MainTabView(
                onEventSelected: { eventID in
                    path.append(.eventDetails(eventID))
                },
                onCategorySelected: { categoryID in
                    path.append(.categorizedEvents(categoryID))
                },
                onLogout: onLogout
            )
            .navigationDestination(for: MainRoute.self) { route in
                switch route {

                case .categorizedEvents(let categoryID):
                    CategorizedEventsView(
                        categoryId: categoryID,
                        onEventSelected: { eventID in
                            path.append(.eventDetails(eventID))
                        }
                    )

                case .eventDetails(let eventID):
                    EventDetailsView(eventId: eventID)
                }
            }
        }
    }
}
