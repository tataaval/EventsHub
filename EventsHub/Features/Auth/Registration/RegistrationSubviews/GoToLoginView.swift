//
//  GoToLoginView.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//

import SwiftUI

struct GoToLoginView: View {
    let title: String
    let onLogin: () -> Void
        
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.gray300)
            Button {
                onLogin()
            } label: {
                Text("Sign In")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
