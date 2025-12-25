import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    let onRegister: () -> Void
    let onResetPassword: () -> Void

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
                ReusableTextfield(
                    title: "Email",
                    placeholder: "Enter your email",
                    text: $viewModel.email
                )
                ReusableTextfield(
                    title: "Password",
                    placeholder: "Enter your password",
                    text: $viewModel.password,
                    isSecure: true
                )
                VStack(spacing: 50) {
                    HStack(spacing: 100) {
                        CheckmarkView(
                            isChecked: $viewModel.isRememberMeChecked,
                            title: "Remember me"
                        )

                        Button {
                            onResetPassword()
                        } label: {
                            Text("Forgor password?")
                                .foregroundStyle(.black)
                                .font(.system(size: 14))
                        }
                    }
                    VStack(spacing: 20) {
                        MainButtonView(
                            title: viewModel.isLoading ? "Signing In..." : "Sign In",
                            action: {
                                viewModel.login()
                            }
                        )
                        .disabled(viewModel.isLoading)
                        HStack {
                            Text("Don't have any account?")
                                .font(.system(size: 14))
                                .foregroundColor(.gray300)
                            Button {
                                onRegister()
                            } label: {
                                Text("Sign Up")
                                    .font(.system(size: 14))
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
        .alert("Login Failed", isPresented: $viewModel.showErrorAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "error")
        }
        Spacer()

    }

}

#Preview {
    LoginView(onRegister: {}, onResetPassword: {})
}
