//
//  ResetPasswordView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//

import SwiftUI

struct ResetPasswordView: View {

    let onBackToLogin: () -> Void

    var body: some View {
        Button("Back to Login", action: onBackToLogin)
    }
}
