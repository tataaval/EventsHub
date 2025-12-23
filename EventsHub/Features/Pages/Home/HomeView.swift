//
//  HomeView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

//temporary models
struct Category: Identifiable {
    let id: Int
    let title: String
    let icon: String
    let eventCount: Int
}

struct TrendingEvent: Identifiable {
    let id: Int
    let title: String
    let date: String
}

struct UpcomingEvent: Identifiable {
    let id: Int
    let date: String
    let title: String
    let time: String
    let location: String
    let description: String
    let registered: String
    let spotsLeft: String
}

struct HomeView: View {
    
    //MARK: - properties
    let onEventSelected: (Int) -> Void
    let onCategorySelected: (Int) -> Void
    let onViewAllTapped: () -> Void
    
    @StateObject private var viewModel: HomeViewModel
    
    init(
        onEventSelected: @escaping (Int) -> Void,
        onCategorySelected: @escaping (Int) -> Void,
        onViewAllTapped: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: HomeViewModel())
        self.onEventSelected = onEventSelected
        self.onCategorySelected = onCategorySelected
        self.onViewAllTapped = onViewAllTapped
    }

    var body: some View {
        VStack {
            HeaderView()
                .padding(.horizontal)
            ScrollView {
                VStack(spacing: 24) {

                    WelcomeView(userName: viewModel.username)

                    UpcomingEventsSection(events: viewModel.upcomingEvents, onEventSelected: onEventSelected, onViewAllTapped: onViewAllTapped)
                    
                    BrowseByCategorySection(categories: viewModel.categories, onCategorySelected: onCategorySelected)
                    
                    TrendingEventsSection(trendingEvents: viewModel.trendingEvents, onEventSelected: onEventSelected)
                }
                .padding()
            }
        }
    }
}
