import Foundation
import Combine

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var otp: [String] = Array(repeating: "", count: 6)
    @Published var isOTPSent: Bool = false
    @Published var showPhoneAlert: Bool = false
    @Published var isTermsChecked: Bool = false
    @Published var showValidationAlert: Bool = false
    @Published var validationMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var registrationSuccess: Bool = false
    @Published var errorMessage: String?
    @Published var showErrorAllert: Bool = false
    @Published var departments: [Department] = []
    @Published var selectedDepartment: Department?
    @Published var isDropdownExpanded: Bool = false
    
    var isUserValid: Bool {
        !firstName.isEmpty
        && !lastName.isEmpty
        && isValidEmali(email: email)
        && isValidPhoneNumber(phoneNumber: phoneNumber)
        && isValidPassword(password: password)
        && password == confirmPassword
        && isTermsChecked
    }
    
    var isPasswordValid: Bool {
        password.count >= 8
    }
    
    private func isValidEmali(email: String) -> Bool {
        email.contains("@") && email.contains(".")
    }
    
    private func isValidPhoneNumber(phoneNumber: String) -> Bool {
        return phoneNumber.count == 9 && phoneNumber.first == "5"
    }
    
    private func isValidPassword(password: String) -> Bool {
        guard password.count >= 8 else { return false}
        guard let first = password.first, first.isUppercase else { return false }
        let containsDigit = password.contains { $0.isNumber }
        return containsDigit
    }

    func fetchDepartments() {
        Task {
            do {
                let result: [Department] = try await NetworkService.shared.fetch(
                    from: EventAPI.departments
                )
                departments = result
            } catch {
                errorMessage = error.localizedDescription
                showErrorAllert = true
            }
        }
    }
    
    func sendOTP() {
        guard isValidPhoneNumber(phoneNumber: phoneNumber) else {
                showPhoneAlert = true
                return
            }
        
        let randomDigits = String(format: "%06d", Int.random(in: 0...999999))
        otp = randomDigits.map { String($0) }
        
        isOTPSent = true
    }
    
    func chooseDepartment(department: Department) {
        selectedDepartment = department
        isDropdownExpanded = false
    }
    
    func toggleDropdown() {
        isDropdownExpanded.toggle()
    }
    
    func registration() {
        guard let departmentId = selectedDepartment?.id else {
           validationMessage = "Please select department"
           showValidationAlert = true
           return
       }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response: RegisterResponse = try await NetworkService.shared.fetch(from: EventAPI.register(
                    firstName: firstName,
                    lastName: lastName,
                    email: email,
                    mobileNumber: phoneNumber,
                    departmentId: departmentId,
                    password: password,
                    confirmPassword: confirmPassword))
                isLoading = false
                registrationSuccess = true
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
                showErrorAllert = true
            }
        }
    }
    
    func submitRegistration() {
        if firstName.isEmpty {
            validationMessage = "Please fill first name"
            showValidationAlert = true
            return
        }
        
        if lastName.isEmpty {
            validationMessage = "Please fill last name"
            showValidationAlert = true
            return
        }
        
        if email.isEmpty {
            validationMessage = "Please fill your email"
            showValidationAlert = true
            return
        }
        
        if !isValidEmali(email: email) {
            validationMessage = "Please enter a valid email"
            showValidationAlert = true
            return
        }
        
        if phoneNumber.isEmpty {
            validationMessage = "Please fill your phone number"
            showValidationAlert = true
            return
        }
        
        if !isValidPhoneNumber(phoneNumber: phoneNumber) {
            validationMessage = "Please enter a valid phone number"
            showValidationAlert = true
            return
        }
        
        if !isOTPSent {
            validationMessage = "Please send and enter OTP code"
            showValidationAlert = true
            return
        }
        
        let isOTPComplete = otp.allSatisfy { !$0.isEmpty }
        if !isOTPComplete {
            validationMessage = "Please enter complete OTP code"
            showValidationAlert = true
            return
        }
        
        if selectedDepartment == nil {
            validationMessage = "Please select department"
            showValidationAlert = true
            return
        }
        
        if password.isEmpty {
            validationMessage = "Please fill your password"
            showValidationAlert = true
            return
        }
        
        if !isValidPassword(password: password) {
            validationMessage = "Password must be at least 8 characters with uppercase letter and number"
            showValidationAlert = true
            return
        }
        
        if confirmPassword.isEmpty {
            validationMessage = "Please confirm your password"
            showValidationAlert = true
            return
        }
        
        if password != confirmPassword {
            validationMessage = "Passwords do not match"
            showValidationAlert = true
            return
        }
        
        if !isTermsChecked {
            validationMessage = "Please agree to the Terms of Service and Privacy Policy"
            showValidationAlert = true
            return
        }
        
        registration()
    }
}
