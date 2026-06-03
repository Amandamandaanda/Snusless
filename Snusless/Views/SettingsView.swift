//
//  SettingsView.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-25.
//

import SwiftData
import SwiftUI
import UserNotifications

struct SettingsView: View {
    @Query private var users: [User]

    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = SettingsViewModel()
    @State private var isPresentingDeleteAlert: Bool = false
    @State private var notificationDate = Date()
    @AppStorage("notificationsEnabled")
    private var isNotificationAuthorized: Bool = false

    var body: some View {
        VStack(spacing: 24) {
            
            Toggle("Slå på notiser", isOn: $isNotificationAuthorized)
                .foregroundStyle(.black)
                .toggleStyle(NotificationToggleStyle())
                .onChange(of: isNotificationAuthorized) { _, newValue in
                    if newValue {
                        requestNotificationPermission( date: notificationDate)
                    } else {
                        cancelNotification()
                    }
                }
            
            if isNotificationAuthorized {
                DatePicker("Välj tid för dina påminnelser", selection: $notificationDate, displayedComponents: [.hourAndMinute])
                    .onChange(of: notificationDate) { _, newDate in
                        sendNotification(date: newDate)
                    }
                }

            Button {
                isPresentingDeleteAlert = true
            } label: {
                HStack {
                    Text("Rensa data")
                        .foregroundStyle(.red)

                    Spacer()

                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .title) {
                Text("Inställningar")
                    .font(.custom("Roboto-Bold", size: 20))
            }
        }
        .padding()
        .alert("Är du säker?", isPresented: $isPresentingDeleteAlert) {
            Button("Radera", role: .destructive) {
                viewModel.deleteData(users: users, context: modelContext)
            }
            
            Button("Avbryt", role: .cancel) {
            }
        } message: {
            Text("All data kommer att raderas.")
        }
        .onChange(of: users.isEmpty) { _, isEmpty in
            if isEmpty {
                dismiss()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
