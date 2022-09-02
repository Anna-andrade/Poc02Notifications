//
//  NotificationListView.swift
//  Poc02Notifications
//
//  Created by Anna Carolina Costa Andrade on 01/09/22.
//

import SwiftUI

struct NotificationListView: View {
    @StateObject private var notificationManager = NotificationManager()
    @State private var isCreatePresented = false
    var body: some View {
        List(notificationManager.notifications, id: \.identifier){notification in
            Text(notification.content.title)
                .fontWeight(.semibold)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Notifications")
        .onAppear(perform: notificationManager.reloadAuthorizationStatus)
        .onChange(of: notificationManager.authorizationStatus){ authorizationStatus in
            switch authorizationStatus{
            case .notDetermined:
                //request authorization
                notificationManager.requestAuthorization()
            case .authorized:
                //get local authorization
                notificationManager.reloadLocalNotifications()
                break
            default:
                break
                
                
            }
        }
        .navigationBarItems(trailing: Button {
            isCreatePresented = true
            
        } label: {
          Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .sheet(isPresented: $isCreatePresented) {
            NavigationView {
                CreateNotificationView(
                    notificationManager: notificationManager,
                    isPresented: $isCreatePresented)
            }
            .accentColor(.primary)
        }
    }
}

struct NotificationListView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView()
    }
}
