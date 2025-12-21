import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
        let onRegister: () -> Void
        let onResetPassword: () -> Void
        let onLoginSuccess: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 10) {
                Text("Sign In")
                    .font(.system(size: 32))
                Text("Enter your credentials to access your account.")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
            
            VStack(alignment: .leading, spacing: 24) {
                ReusableTextfield(title: "Email", placeholder: "Enter your email", text: $viewModel.email)
                ReusableTextfield(title: "Password", placeholder: "Enter your password", text: $viewModel.password)
                
                VStack(spacing: 50) {
                    HStack(spacing: 100) {
                        CheckmarkView(isChecked: $viewModel.isTermsChecked, title: "Remember me")
                        
                        Button {
                            onResetPassword()
                        } label: {
                            Text("Forgor password?")
                                .foregroundStyle(.black)
                                .font(.system(size: 14))
                        }
                    }
                    VStack(spacing: 20) {
                        MainButtonView(title: "Sign In", action: {})
                        HStack {
                            Text("Don't have any account?")
                                .fontWeight(.light)
                            Button {
                                onRegister()
                            } label: {
                                Text("Sign Up")
                                    .foregroundStyle(.black)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 150)
        Spacer()

    }
    
}

#Preview {
    LoginView(onRegister: {}, onResetPassword: {}, onLoginSuccess: {})
}
