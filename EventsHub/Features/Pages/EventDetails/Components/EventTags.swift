//
//  EventTags.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct EventTags: View {
    //MARK: - Properties
    let tags: [String]
    
    //MARK: - Body
    var body: some View {
        HStack(spacing: 8) {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(.system(size: 12))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.gray100)
                    .foregroundColor(.gray900)
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal)
    }
}
