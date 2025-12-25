//
//  RegisterSection.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct RegisterSection: View {

    let registrationDeadline: String
    let title: String
    let isEnabled: Bool
    let onTap: () -> Void

    var body: some View {
        VStack(spacing: 12) {

            Button(action: onTap) {
                Text(title)
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isEnabled ? Color.black : Color.gray.opacity(0.4))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!isEnabled)

            Text(registrationDeadline)
                .font(.system(size: 12))
                .foregroundColor(.gray300)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal)
    }
}
