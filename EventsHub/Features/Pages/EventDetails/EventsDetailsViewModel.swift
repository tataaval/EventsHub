//
//  EventsDetailsViewModel.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//

import Combine

final class EventsDetailsViewModel: ObservableObject {
    @Published var event: EventDetailsModel?

    init(eventID: Int) {
        self.event = EventDetailsModel(
            title: "Leadership Workshop: Effective Communication",
            date: "December 20, 2025",
            time: "02:00 PM - 04:30 PM", tags: ["outdoor", "team-building"],
            location: "Training Room B, Building 4",
            registrationInfo: "129 registered, 7 spots left",
            registrationDeadline:
                "Registration closes on Dec 19, 2025 at 5:00 PM.",
            description: """
                Enhance your leadership skills with this interactive workshop focusing on communication strategies,
                active listening, and team motivation techniques. This session is designed for new and aspiring leaders
                looking to build a strong foundation in effective team management and communication.
                """,
            agenda: [
                AgendaItem(
                    order: 1,
                    title: "02:00 PM - Welcome & Introduction",
                    description:
                        "Overview of the workshop goals and key topics."
                ),
                AgendaItem(
                    order: 2,
                    title: "02:15 PM - The Art of Active Listening",
                    description:
                        "Interactive exercises on understanding and responding."
                ),
                AgendaItem(
                    order: 3,
                    title: "03:30 PM - Q&A and Closing Remarks",
                    description: "Open forum and summary of key takeaways."
                ),
            ],
            speakers: [
                Speaker(
                    name: "Sarah Johnson",
                    role: "VP of Human Resources"
                ),
                Speaker(
                    name: "David Chen",
                    role: "Lead Corporate Trainer"
                ),
            ],
            faq: [
                Faq(question: "Frequently Asked Questions", answer: "You can cancel your registration up to 24 hours before the event through this app. This will allow someone from the waitlist to attend.")
            ]
            
        )
    }
}
