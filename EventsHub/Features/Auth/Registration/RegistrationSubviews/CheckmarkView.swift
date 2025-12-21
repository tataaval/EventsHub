import SwiftUI

struct CheckmarkView: View {
    @Binding var isChecked: Bool
    let title: String

    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .onTapGesture {
                    self.isChecked.toggle()
                }
            Text(title)
                .foregroundStyle(.black)
                .font(.system(size: 14))
        }
    }
}
