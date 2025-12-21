//
//  RegisterSection.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

struct RegisterSection: View {

    let registrationDeadline: String
    let onRegister: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: onRegister) {
                Text("Register Now")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 8)

            Text(registrationDeadline)
                .font(.system(size: 12))
                .foregroundColor(.gray300)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal)
    }
}
