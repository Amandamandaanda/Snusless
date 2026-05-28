//
//  ProfileView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-27.
//

import SwiftData
import SwiftUI

struct ProfileView: View {

    @State private var showingEditProfileSheet = false

    @Query private var users: [User]

    var body: some View {
        VStack {
                        
            VStack(alignment: .leading, spacing: 20) {
                if let user = users.first {
                    SummaryRow(
                        title:
                            String(localized: "Namn:"),
                        value: user.name
                    )
                    SummaryRow(
                        title: String(localized: "Startdatum:"),
                        value: user.startDate.formattedMedium()
                    )
                    SummaryRow(
                        title: String(localized: "Dosor per dag:"),
                        value: "\((user.numberOfDosor))"
                    )
                    SummaryRow(
                        title: String(localized: "Portioner per dosa:"),
                        value: "\(user.portionsPerDosa)"
                    )
                    SummaryRow(
                        title: String(localized: "Pris per dosa:"),
                        value: String(
                            format: "%.2f kr",
                            (user.pricePerDosa))
                    )
                    SummaryRow(
                        title: String(localized: "Sparmål:"),
                        value: "\((user.savingsGoal)) kr"
                    )
                }
            }
            .padding()
            .background(.lightGreen)
            .cornerRadius(15)
            .padding(.vertical, 30)
            .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)

            Button {
                showingEditProfileSheet = true
            } label: {
                Text("Redigera")
                    .font(.custom("Roboto-Bold", size: 18))
                    .foregroundColor(.darkGreen)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.lightGreen.opacity(0.2))
                    .cornerRadius(15)
            }

            Spacer()
        }
        .padding(20)
        .toolbar {
            ToolbarItem(placement: .title) {
                Text("Profil")
                    .font(.custom("Roboto-Bold", size: 20))
                    .foregroundColor(.black)
            }

            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gear")
                }

            }
        }
        .sheet(isPresented: $showingEditProfileSheet) {
            NavigationStack {
                EditProfileView()
            }
        }
    }
}

#Preview("Swedish") {
    NavigationStack {
        ProfileView()
    }
}

#Preview("English") {
    NavigationStack {
        ProfileView()
            .environment(\.locale, Locale(identifier: "ENG"))
    }
}
