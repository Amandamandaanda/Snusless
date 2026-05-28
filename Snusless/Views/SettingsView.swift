//
//  SettingsView.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-25.
//

import SwiftData
import SwiftUI

struct SettingsView: View {
    @Query private var users: [User]

    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = SettingsViewModel()
    @State private var isPresentingDeleteAlert: Bool = false

    var body: some View {
        VStack(spacing: 24) {
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
