//
//  HomeView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

struct HomeView: View {

    let onEventSelected: (Int) -> Void
    let onCategorySelected: (Int) -> Void

    var body: some View {
        VStack {
            Button("კატეგორიის გვერდზე გადასვლა") {
                onCategorySelected(1)
            }
            Button("კონკრეტულ ივენთზე შესვლა") {
                onEventSelected(3)
            }
        }
    }
}
