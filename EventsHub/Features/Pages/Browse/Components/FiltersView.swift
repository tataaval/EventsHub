//
//  FiltersView.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

enum BrowseEventCategory: String, CaseIterable, Identifiable {
    case all
    case teamBuilding
    case workshop
    case wellness

    var id: String { rawValue }

    var title: String {
        switch self {
        case .all: "All"
        case .teamBuilding: "Team Building"
        case .workshop: "Workshop"
        case .wellness: "Wellness"
        }
    }
}

struct FiltersView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var selectedCategory: BrowseEventCategory = .all
    @State private var startDate = Date()
    @State private var endDate = Date()

    var body: some View {
        NavigationStack {
            Form {
                Picker("არ ვიცით რა ხდება", selection: $selectedCategory) {
                    ForEach(BrowseEventCategory.allCases) {
                        Text($0.title).tag($0)
                    }
                }
                DatePicker(
                    "Start date",
                    selection: $startDate,
                    displayedComponents: .date
                )
                DatePicker(
                    "End date",
                    selection: $endDate,
                    displayedComponents: .date
                )
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset") {
                        resetFilters()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        applyFilters()
                        dismiss()
                    }
                }
            }
        }
    }

    private func resetFilters() {
        selectedCategory = .all
    }

    private func applyFilters() {
        //TODO: როცა იქნება
    }
}
