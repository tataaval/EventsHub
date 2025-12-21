import SwiftUI

struct MainButtonView: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 46)
                .background(Color.black)
                .cornerRadius(6)
        }
    }
}

