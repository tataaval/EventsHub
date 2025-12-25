//
//  MyEventsView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

struct MyEventsView: View {

    @StateObject private var viewModel: MyEventsViewModel
    let onEventSelected: (Int) -> Void

    init(onEventSelected: @escaping (Int) -> Void) {
        _viewModel = StateObject(wrappedValue: MyEventsViewModel())
        self.onEventSelected = onEventSelected
    }

    var body: some View {
        VStack {
            Text("My Events")
                .font(.system(size: 20, weight: .bold))
                .padding(.top, 20)
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.events) { registration in
                        Button {
                            onEventSelected(registration.eventId)
                        } label: {
                            EventRegistrationCardView(
                                registration: registration
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .refreshable {
                await viewModel.fetchMyEvents()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchMyEvents()
            }
        }
    }
}
