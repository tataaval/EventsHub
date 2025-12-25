//
//  BrowseByCategorySection.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct BrowseByCategorySection: View {
    //MARK: - properties
    let categories: [EventCategoryModel]
    let onCategorySelected: (String) -> Void
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Browse by Category")
                .font(.system(size: 18))
                .foregroundStyle(.gray900)
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(categories) { category in
                    CategoryCardView(
                        category: category,
                        onTap: onCategorySelected
                    )
                }
            }
        }
    }
}
