//
//  CategorizedEventsView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

struct CategorizedEventsView: View {
    
    let categoryId: Int //TODO: ვიუმოდელში უნდა გაეტანოს
    let onEventSelected: (Int) -> Void

    var body: some View {
        Button("ამ კატეგორიის რომელიმე ივენთი \(categoryId)") {
            onEventSelected(3)
        }
    }
}
