import Foundation
import Combine

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
    @Published var selectedDepartment: String = "Select Department"
    @Published var isDropdownExpanded: Bool = false
    @Published var isTermsChecked: Bool = false
    @Published var showValidationAlert: Bool = false
    @Published var validationMessage: String = ""
    let options = ["Organizer", "Employee"]
    
    
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
    
    func sendOTP() {
        guard isValidPhoneNumber(phoneNumber: phoneNumber) else {
                showPhoneAlert = true
                return
            }
        
        let randomDigits = String(format: "%06d", Int.random(in: 0...999999))
        otp = randomDigits.map { String($0) }
        
        isOTPSent = true
    }
    
    func chooseDepartment(department: String) {
        selectedDepartment = department
        isDropdownExpanded = false
    }
    
    func toggleDropdown() {
        isDropdownExpanded.toggle()
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
        
        if selectedDepartment == "Select Department" {
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
        
    }
}
