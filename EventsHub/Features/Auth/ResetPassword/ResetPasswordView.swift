import SwiftUI

struct ResetPasswordView: View {
    @Binding var text: String
    let onBackToLogin: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 10) {
                Text("Forgot Password")
                    .font(.system(size: 32))
                Text("Enter your email and we'll send you a link to reset your password.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                
                HStack(spacing: -4) {
                    Image("mail")
                        .resizable()
                        .frame(width: 14, height: 14)
                    
                    TextField("Enter your email", text: $text, prompt: Text("Enter your email").font(.system(size: 14)).foregroundStyle(.gray))
                        .padding()
                        .keyboardType(.default)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .font(.system(size: 14))
                }
                .padding(.leading, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(height: 46)
                )
            }
            
            MainButtonView(title: "Send Reset Link", action: {} )
            
            HStack {
                Button {
                    onBackToLogin()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.gray500)
                    Text("Back to Sign In")
                        .foregroundStyle(.gray500)
                }
            }
            
        }
        .padding(.horizontal, 24)
        .padding(.top, 180)
        Spacer()
        
    }
    
}

#Preview {
    ResetPasswordView(text: .constant("Managa"), onBackToLogin: {})
}
