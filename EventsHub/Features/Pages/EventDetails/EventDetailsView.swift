//
//  EventDetailsView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

struct EventDetailsView: View {

    @StateObject private var viewModel: EventsDetailsViewModel

    init(eventId: Int) {
        _viewModel = StateObject(
            wrappedValue: EventsDetailsViewModel(eventID: eventId)
        )
    }

    var body: some View {
        Group {
            if let event = viewModel.event {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        EventBanner(imageURL: URL(string: event.imageUrlNormalized))
                        
                        EventTags(tags: event.tags)
                        
                        EventInfoSection(event: event)
                        Divider()
                        RegisterSection(
                            registrationDeadline: event.registrationDeadlineText,
                            title: viewModel.buttonTitle,
                            isEnabled: viewModel.isButtonEnabled,
                            onTap: viewModel.handleRegisterButtonTap
                        )
                        Divider()
                        if let description = event.description {
                            AboutEventSection(description: description)
                        }
                        
                        //TODO: - cleanup
                        //                    Divider()
                        //                    AgendaSection(items: event.agenda)
                        //                    Divider()
                        //                    SpeakersSection(speakers: event.speakers)
                        //                    Divider()
                        //                    FaqSection(items: event.faq)
                    }
                }
                .navigationTitle("Event Details")
            } else {
                ProgressView("Loading...")
            }
        }
        .task {
            await viewModel.load()
        }
    }
}
