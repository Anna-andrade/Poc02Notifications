//
//  CreateNotificationView.swift
//  Poc02Notifications
//
//  Created by Anna Carolina Costa Andrade on 01/09/22.
//

import SwiftUI

struct CreateNotificationView: View {
    @State private var title = ""
    @State private var date = Date()
    var body: some View {
        List {
            Section {
                VStack{
                    HStack{
                        TextField("Notification Title", text: $title)
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                    }
                }
            }
        }
    }
}

struct CreateNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNotificationView()
    }
}
