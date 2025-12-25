//
//  MyEventsViewModel.swift
//  EventsHub
//
//  Created by Tatarella on 25.12.25.
//

import Combine
import Foundation

@MainActor
final class MyEventsViewModel: ObservableObject {
    
    //MARK: - published properties
    @Published var events: [EventRegistration] = []

    //MARK: - init
    init() {
        Task {
            await fetchMyEvents()
        }
    }
    
    func fetchMyEvents() async {
        do {
            events = try await NetworkService.shared.fetch(from: EventAPI.myEvents)
        } catch {
            print(error.localizedDescription)
        }
    }

}
