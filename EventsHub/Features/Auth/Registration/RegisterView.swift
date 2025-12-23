//
//  RegisterView.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel: RegisterViewModel
    let onLogin: () -> Void
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Create Account")
                    .font(.system(size: 32))
                Text("Enter your details to get started.")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack(spacing: 14) {
                        ReusableTextfield(title: "First Name", placeholder: "Your first name", text: $viewModel.firstName)
                        ReusableTextfield(title: "Last Name", placeholder: "Your last name", text: $viewModel.lastName)
                    }
                    ReusableTextfield(title: "Email", placeholder: "managaluka@gmail.com", text: $viewModel.email)
                    HStack {
                        ReusableTextfield(title: "Phone Number", placeholder: "+(995) 000-000-000", text: $viewModel.phoneNumber)
                        
                        Button {
                            viewModel.sendOTP()
                        } label: {
                            Text("Send OTP")
                                .padding()
                                .background(Color.gray)
                                .frame(height: 46)
                                .foregroundStyle(.white)
                                .cornerRadius(6)
                                .padding(.top, 26)
                        }
                        .disabled(viewModel.isOTPSent)
                    }
                    OTPView(otp: $viewModel.otp)
                    DropDownView(
                        selectedOption: Binding(
                            get: { viewModel.selectedDepartment?.name ?? "Select Department" },
                            set: { _ in }
                        ),
                        isExpanded: $viewModel.isDropdownExpanded,
                        options: viewModel.departments.map { $0.name },
                        onSelect: { name in
                            viewModel.selectedDepartment = viewModel.departments.first {
                                $0.name == name
                            }
                        }
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        ReusableTextfield(title: "Password", placeholder: "Fill your password", text: $viewModel.password, isSecure: true)
                        Text("Password must be at least 8 characters with uppercase, lowercase, and number.")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                    ReusableTextfield(title: "Confirm Password", placeholder: "Confirm your password", text: $viewModel.confirmPassword, isSecure: true)
                    CheckmarkView(isChecked: $viewModel.isTermsChecked, title: "I agree to the Terms of Service and Privacy Policy")
                    MainButtonView(title: viewModel.isLoading ? "Creating Account..." : "Create Account", action: { viewModel.submitRegistration() } )
                        .disabled(viewModel.isLoading)
                    
                    GoToLoginView(title: "Already have an account?", onLogin: onLogin)
                }
                .padding(.horizontal, 24)
                .padding(.top, 50)
            }
            .padding(.top, 30)
            Spacer()
        }
        .alert("Invalid Phone Number", isPresented: $viewModel.showPhoneAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please write correct number")
        }
        .alert("Error", isPresented: $viewModel.showValidationAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.validationMessage)
        }
        .alert("Success", isPresented: $viewModel.registrationSuccess) {
            Button("OK", role: .cancel) { onLogin() }
        } message: {
            Text("Registration Succeed")
        }
        .alert("Registration Failed", isPresented: $viewModel.showErrorAllert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "Try Again")
        }
        .onAppear {
            viewModel.fetchDepartments()
        }
    }
}
