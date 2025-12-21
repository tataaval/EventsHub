import SwiftUI

struct OTPView: View {
    @Binding var otp: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Image("otp")
                    .resizable()
                    .frame(width: 14, height: 14)
                
                Text("Enter OTP Code")
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
            }
            
            HStack(spacing: 10) {
                ForEach(0..<6, id: \.self) { i in
                    Text(i < otp.count ? otp[i] : "")
                        .frame(width: 46, height: 46)
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
        }
    }
}
