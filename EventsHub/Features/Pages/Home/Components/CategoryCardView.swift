//
//  CategoryCardView.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct CategoryCardView: View {
    //MARK: - properties
    let category: EventCategoryModel
    let onTap: (String) -> Void
    
    //MARK: - body
    var body: some View {
        VStack(spacing: 10) {
            Image(category.name.snakeCased)
                .font(.system(size: 24))
                .foregroundColor(.gray300)
            
            Text(category.name)
                .font(.system(size: 14))
                .foregroundColor(.gray900)
                .multilineTextAlignment(.center)
            
            Text("\(category.eventCount) events")
                .font(.system(size: 12))
                .foregroundColor(.gray300)
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .padding()
        .background(.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .onTapGesture {
            onTap(category.name)
        }
    }
}
