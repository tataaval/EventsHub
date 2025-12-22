import SwiftUI

struct NotificationsView: View {
    @StateObject var viewModel: NotificationsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 36) {
                    ForEach(NotificationsType.allCases) { type in
                        Button {
                            viewModel.selectType(type)
                        } label: {
                            VStack(spacing: 8) {
                                Text(type.rawValue)
                                    .font(.system(size: 14))
                                    .foregroundStyle(
                                        viewModel.selectedType == type ? .black : .gray
                                    )
                                
                                Rectangle()
                                    .fill(viewModel.selectedType == type ? Color.black : Color.clear)
                                    .frame(height: 2)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 30)
            }
            
            Rectangle()
                .fill(Color.gray100)
                .frame(height: 1)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if !viewModel.newNotifications.isEmpty {
                        Text("NEW")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 4)
                        
                        ForEach(viewModel.newNotifications) { notification in
                            NotificationCard(notification: notification)
                        }
                    }
                    
                    if !viewModel.earlierNotifications.isEmpty {
                        Text("EARLIER")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                            .padding(.top, viewModel.newNotifications.isEmpty ? 0 : 8)
                            .padding(.bottom, 4)
                        
                        ForEach(viewModel.earlierNotifications) { notification in
                            NotificationCard(notification: notification)
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
        }
    }
}



#Preview {
    NotificationsView(viewModel: NotificationsViewModel())
}
