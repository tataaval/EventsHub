import SwiftUI

struct NotificationCard: View {
    let notification: Notifications
    @State private var showSheet = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: notification.iconName)
                .foregroundStyle(.gray)
                .frame(width: 40, height: 40)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(notification.title)
                    .font(.system(size: 16))
                    .foregroundStyle(.primary)
                
                Text(notification.timeline)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if notification.isUnread {
                Circle()
                    .fill(Color.black)
                    .frame(width: 8, height: 8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 3)
        .onTapGesture {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            NotificationsDetailView(notification: notification)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    NotificationCard(notification: Notifications(type: .all, status: .earlier, title: "asdjasksfksajfkajsjfkajkfasjfksajfajf", workshopTitle: "workshop title", timeline: "1 minutachku ago", eventTime: "125, 1251,32 13", location: "kutaisisimon", isUnread: true))
}
