//
//  NewProfileView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-27.
//

import SwiftData
import SwiftUI

struct NewProfileView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel

    @State private var showingEditProfileSheet = false

    var body: some View {
        ZStack {
            VStack {

                Text("Profil")
                    .font(.custom("Roboto-Bold", size: 26))
                    .foregroundColor(.black)
                    .padding(.vertical, 40)

                VStack(alignment: .leading, spacing: 20) {
                    SummaryRow(
                        title:
                            String(localized: "Namn:"),
                        value: onboardingViewModel.name
                    )
                    SummaryRow(
                        title: String(localized: "Startdatum:"),
                        value: onboardingViewModel.startDate.formattedMedium()
                    )
                    SummaryRow(
                        title: String(localized: "Dosor per dag:"),
                        value: "\((onboardingViewModel.numberOfDosor ?? 0))"
                    )
                    SummaryRow(
                        title: String(localized: "Portioner per dosa:"),
                        value: "\(onboardingViewModel.portionsPerDosa)"
                    )
                    SummaryRow(
                        title: String(localized: "Pris per dosa:"),
                        value: String(
                            format: "%.2f kr",
                            (onboardingViewModel.pricePerDosa ?? 0)
                        )
                    )
                    SummaryRow(
                        title: String(localized: "Sparmål"),
                        value: "\((onboardingViewModel.savingGoal ?? 0)) kr"
                    )
                }
                .padding()
                .background(.lightGreen)
                .cornerRadius(15)
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)

                Button {
                    showingEditProfileSheet = true
                } label: {
                    Text("Redigera")
                        .font(.custom("Roboto-Medium", size: 18))
                        .foregroundColor(.darkGreen)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.lightGreen.opacity(0.2))
                        .cornerRadius(15)
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .toolbar {
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
                    ProfileView(isPresented: $showingEditProfileSheet)
                }
            }
        }
    }
}

#Preview("Swedish") {
    NewProfileView()
        .environment(OnboardingViewModel())

}

#Preview("English") {
    NewProfileView()
        .environment(OnboardingViewModel())
        .environment(\.locale, Locale(identifier: "ENG"))

}
