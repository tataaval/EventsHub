import SwiftUI

struct NotificationsDetailView: View {
    let notification: Notifications
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                Text(notification.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                        .foregroundStyle(.secondary)
                    Text(notification.timeline)
                        .font(.system(size: 14))
                }
                
                Spacer()
                
                MainButtonView(title: "Close", action: { dismiss() })
            }
            .padding(.horizontal, 24)
            .padding(.top, 30)
        }
    }
}
