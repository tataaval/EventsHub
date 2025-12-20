//
//  BrowseView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

struct BrowseView: View {

    let onEventSelected: (Int) -> Void

    var body: some View {
        Button("browse გვერდიდან რომელიმე ივენთი") {
            onEventSelected(3)
        }
    }
}
