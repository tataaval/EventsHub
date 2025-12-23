import Combine
import Foundation

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isRememberMeChecked: Bool = false
    @Published var showErrorAlert = false

    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required"
            showErrorAlert = true
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let response: LoginResponse = try await NetworkService.shared.fetch(from: EventAPI.login(email: email, password: password))

                SessionManager.shared.login(
                    token: response.token,
                    profile: UserProfile(
                        userId: response.userId,
                        fullName: response.fullName,
                        role: response.role
                    )
                )

                isLoading = false

            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
                showErrorAlert = true
            }
        }
    }
}
