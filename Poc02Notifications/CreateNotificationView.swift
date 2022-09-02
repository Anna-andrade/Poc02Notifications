//
//  CreateNotificationView.swift
//  Poc02Notifications
//
//  Created by Anna Carolina Costa Andrade on 01/09/22.
//

import SwiftUI

struct CreateNotificationView: View {
    @ObservedObject var notificationManager: NotificationManager
    @State private var title = ""
    @State private var date = Date()
    @Binding var isPresented: Bool
    var body: some View {
        List {
            Section {
                VStack{
                    HStack{
                        TextField("Notification Title", text: $title)
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                    }
                    Button{
                        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
                        guard let hour = dateComponents.hour, let minute = dateComponents.minute else {return}
                        notificationManager.createLocalNotification(title: title, hour: hour, min: minute)
                        {error in
                            if error == nil {
                                DispatchQueue.main.async {
                                    self.isPresented = false
                                }
                            }
                        }
                    } label: {
                        Text("Create")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onDisappear{
            notificationManager.reloadLocalNotifications()
        }
        .navigationTitle("Create")
        .navigationBarItems(trailing: Button{
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .imageScale(.large)
        })
    }
}

struct CreateNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNotificationView(
            notificationManager: NotificationManager(),
            isPresented: .constant(false))
    }
}
