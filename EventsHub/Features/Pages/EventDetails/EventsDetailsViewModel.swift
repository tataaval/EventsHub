//
//  EventsDetailsViewModel.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//

import Combine

//TODO: - ესენი სადმე წავიღო
enum RegistrationStatus: String, Decodable {
    case cancelled = "Cancelled"
    case waitlisted = "Waitlisted"
    case notRegistered = "NotRegistered"
    case confirmed = "Confirmed"
}

enum RegisterButtonState {
    case register
    case cancel
    case disabled
}

@MainActor
final class EventsDetailsViewModel: ObservableObject {

    @Published var event: EventDetailModel?
    @Published var registerStatus: RegistrationStatus?

    private let eventID: Int
    private let network: NetworkServiceProtocol
    private let session: SessionManager

    var buttonState: RegisterButtonState {
        guard let status = registerStatus else { return .disabled }

        switch status {
        case .notRegistered:
            return .register
        case .confirmed, .waitlisted:
            return .cancel
        case .cancelled:
            return .disabled
        }
    }

    var buttonTitle: String {
        switch buttonState {
        case .register:
            return "Register"
        case .cancel:
            return "Cancel Registration"
        case .disabled:
            return "Registration Closed"
        }
    }

    var isButtonEnabled: Bool {
        buttonState != .disabled
    }

    init(
        eventID: Int,
        network: NetworkServiceProtocol,
        session: SessionManager
    ) {
        self.eventID = eventID
        self.network = network
        self.session = session
    }

    convenience init(eventID: Int) {
        self.init(
            eventID: eventID,
            network: NetworkService.shared,
            session: SessionManager.shared
        )
    }

    func load() async {
        do {
            let event: EventDetailModel =
                try await network.fetch(
                    from: EventAPI.getEventDetails(id: eventID)
                )

            let status: RegistrationStatusModel =
                try await network.fetch(
                    from: EventAPI.checkRegistrationon(eventId: eventID)
                )

            self.event = event
            self.registerStatus = status.status
        } catch {
            print(error)
        }
    }

    func handleRegisterButtonTap() {
        guard let eventId = event?.id else { return }

        Task {
            do {
                switch buttonState {
                case .register:
                    try await register(eventId: eventId)
                case .cancel:
                    try await cancelRegistration(eventId: eventId)
                case .disabled:
                    return
                }
            } catch {
                print(error)
            }
        }
    }

    private func register(eventId: Int) async throws {
        guard let userId = session.profile?.userId else { return }
        
        let response: EventRegistrationResponseModel =
            try await network.fetch(
                from: EventAPI.registerForEvent(eventId: eventId, userId: userId)
            )

        registerStatus = RegistrationStatus(rawValue: response.status)
    }

    private func cancelRegistration(eventId: Int) async throws {
        let _: EmptyResponse = try await network.fetch(
            from: EventAPI.cancelRegistration(eventId: eventId)
        )

        registerStatus = RegistrationStatus.cancelled
    }
}
