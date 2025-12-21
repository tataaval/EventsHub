//
//  CategoryCardView.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct CategoryCardView: View {
    //MARK: - properties
    let category: Category
    let onTap: (Int) -> Void
    
    //MARK: - body
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: category.icon)
                .font(.system(size: 24))
                .foregroundColor(.gray300)
            
            Text(category.title)
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
            onTap(category.id)
        }
    }
}
