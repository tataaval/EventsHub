import SwiftUI

struct NotificationsDetailView: View {
    let notification: Notifications
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                Text(notification.workshopTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack(spacing: 8) {
                    Image(systemName: "calendar")
                        .foregroundStyle(.secondary)
                    Text(notification.eventTime)
                        .font(.system(size: 14))
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "location")
                        .foregroundStyle(.secondary)
                    Text(notification.location)
                        .font(.system(size: 14))
                }
                
                VStack(spacing: 12) {
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                            Text("Send a question about the event")
                            Spacer()
                        }
                        .foregroundStyle(.gray500)
                        .padding()
                        .cornerRadius(8)
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "calendar.badge.plus")
                            Text("Add to my calendar")
                            Spacer()
                        }
                        .foregroundStyle(.gray500)
                        .padding()
                        .cornerRadius(8)
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    MainButtonView(title: "Cancel Registration", action: {  })
                }
                .padding(.bottom, 8)
                
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                        .font(.subheadline)
                        .foregroundStyle(.gray300)
                        .frame(maxWidth: .infinity)
                }
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
            .padding(.top, 30)
        }
    }
}

#Preview {
    NotificationsDetailView(notification: Notifications(id: UUID(), type: .all, status: .new, title: "Tech Talk: AI in Business", workshopTitle: "Tech Talk: AI in Business", timeline: "1 hour ago", eventTime: "Jan 26, 2025, 11:00 AM - 12:30 PM", location: "Virtual Meeting", isUnread: false))
}
