//
//  HeaderView.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//

import SwiftUI

struct HeaderView: View {
    //MARK: Body
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray900)
                    .frame(width: 32, height: 32)

                Text("EventHub")
                    .font(.system(size: 18))
            }

            Spacer()

            HStack(spacing: 16) {
                Image(systemName: "bell")
                    .font(.title3)

                Image(systemName: "photo")
                    .font(.title3)
            }
        }
    }
}
