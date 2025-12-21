//
//  BrowseView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

enum EventCategory: String, CaseIterable, Identifiable {
    case all, teamBuilding, workshop, wellness
    var id: String { rawValue }

    var title: String {
        switch self {
        case .all: "All"
        case .teamBuilding: "Team Building"
        case .workshop: "Workshops"
        case .wellness: "Wellness"
        }
    }
}

struct Event {
    let id: Int
    let title: String
    let category: String
    let month: String
    let day: String
    let time: String
    let location: String
    let registered: Int
    let spotsLeft: Int
    let status: String
}

struct BrowseView: View {
    //MARK: - Properties
    @StateObject private var viewModel: BrowseViewModel
    @Binding var preselectedCategory: EventCategory?

    @State private var searchText = ""
    @State private var showFilters = false

    let onEventSelected: (Int) -> Void

    //MARK: - Init
    init(
        preselectedCategory: Binding<EventCategory?>,
        onEventSelected: @escaping (Int) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: BrowseViewModel())
        _preselectedCategory = preselectedCategory
        self.onEventSelected = onEventSelected
    }

    //MARK: - Body
    var body: some View {
        VStack {
            header
            searchAndFilter
            categories

            ScrollView {
                LazyVStack {
                    ForEach(viewModel.events, id: \.id) { event in
                        BrowseEventCardView(
                            event: event,
                            onEventSelected: onEventSelected
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            if let category = preselectedCategory {
                viewModel.selectedCategory = category
                preselectedCategory = nil
            } else {
                viewModel.selectedCategory = .all
            }
        }
        .sheet(isPresented: $showFilters) {
            FiltersView()
                .presentationDetents([.medium, .large])
        }
    }

    //MARK: - Helper Views
    private var header: some View {
        HStack {
            Text("Browse Events")
                .font(.system(size: 20))

            Spacer()

            Button {
                print("აქ არ ვიცი რა ხდება")
            } label: {
                Image(systemName: "calendar")
                    .font(.system(size: 18))
                    .foregroundStyle(.gray500)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }

    private var searchAndFilter: some View {
        HStack(spacing: 8) {

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray300)
                TextField("Search events", text: $searchText)
            }
            .padding(10)
            .background(Color(.gray300).opacity(0.2))
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )

            Button {
                showFilters = true
            } label: {
                HStack {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.gray300)
                    Text("Filters")
                        .foregroundColor(.gray300)

                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color(.white))
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            }
        }
        .padding(.horizontal)
    }

    private var categories: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(EventCategory.allCases) { category in
                    Button {
                        viewModel.selectedCategory = category
                    } label: {
                        Text(category.title)
                            .font(.subheadline)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                viewModel.selectedCategory == category
                                    ? Color.black
                                    : Color(.systemBackground)
                            )
                            .foregroundColor(
                                viewModel.selectedCategory == category
                                    ? .white
                                    : .primary
                            )
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                        Color.gray.opacity(0.2),
                                        lineWidth: 1
                                    )
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
