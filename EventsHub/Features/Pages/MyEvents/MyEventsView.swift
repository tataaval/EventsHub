//
//  MyEventsView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//


import SwiftUI

struct MyEventsView: View {

    let onEventSelected: (Int) -> Void

    var body: some View {
        Button("MyEventsView გვერდიდან რომელიმე ივენთი") {
            onEventSelected(3)
        }
    }
}
