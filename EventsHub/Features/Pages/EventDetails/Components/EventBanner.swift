//
//  EventBanner.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct EventBanner: View {
    //MARK: - Properties
    let imageURL: URL?

    //MARK: - Body
    var body: some View {
        ZStack {
            if let imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ZStack{
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                        Image(systemName: "photo")
                    }
                }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
        }
        .frame(height: 192)
        .clipped()
    }
}
