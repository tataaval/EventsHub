import SwiftUI

struct ReusableTextfield: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(.black)
            
            if isSecure {
                SecureField(placeholder, text: $text, prompt: Text(placeholder).font(.system(size: 14)).foregroundStyle(.gray))
                    .padding()
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 14))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(height: 46)
                    )
            } else {
                TextField(placeholder, text: $text, prompt: Text(placeholder).font(.system(size: 14)).foregroundStyle(.gray))
                    .padding()
                    .keyboardType(.default)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 14))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1)
                            .frame(height: 46)
                    )
            }
        }
    }
}

#Preview {
    ReusableTextfield(title: "First Name", placeholder: "First Name", text: .constant("Managa"))
}
