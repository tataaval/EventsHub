//
//  EventDetailsView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

struct EventDetailsModel {
    let title: String
    let date: String
    let time: String
    let tags: [String]
    let location: String
    let registrationInfo: String
    let registrationDeadline: String
    let description: String
    let agenda: [AgendaItem]
    let speakers: [Speaker]
    let faq: [Faq]
}

struct AgendaItem: Identifiable {
    let id = UUID()
    let order: Int
    let title: String
    let description: String
}

struct Speaker: Identifiable {
    let id = UUID()
    let name: String
    let role: String
}

struct Faq: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct EventDetailsView: View {

    @StateObject private var viewModel: EventsDetailsViewModel

    init(eventId: Int) {
        _viewModel = StateObject(
            wrappedValue: EventsDetailsViewModel(eventID: eventId)
        )
    }

    var body: some View {
        if let event = viewModel.event {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    EventBanner(imageURL: URL(string: "https://picsum.photos/400/300?grayscale"))

                    EventTags(tags: event.tags)

                    EventInfoSection(event: event)
                    Divider()
                    RegisterSection(registrationDeadline: event.registrationDeadline) {
                           print("რეგისტრაციის ღილაკი")
                    }
                    Divider()
                    AboutEventSection(description: event.description)
                    Divider()
                    AgendaSection(items: event.agenda)
                    Divider()
                    SpeakersSection(speakers: event.speakers)
                    Divider()
                    FaqSection(items: event.faq
                    )
                }
            }
            .navigationTitle("Event Details")
        } else {
            ProgressView("Loading...")
        }
    }
}
