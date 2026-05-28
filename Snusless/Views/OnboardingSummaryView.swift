//
//  OnboardingSummaryView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-21.
//

import SwiftData
import SwiftUI

struct OnboardingSummaryView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel

    var saveUser: () -> Void
    var onPreviousStep: () -> Void

    var body: some View {
        ZStack {
            Color(.lightGreen)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                Text("Sammanfattning")
                    .font(.custom("Roboto-Bold", size: 26))
                    .foregroundColor(.white)

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
                        title: String(localized: "Sparmål:"),
                        value: "\((onboardingViewModel.savingGoal ?? 0)) kr"
                    )
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(15)
                .padding(.horizontal, 20)

                if !onboardingViewModel.errorMessage.isEmpty {
                    Text(onboardingViewModel.errorMessage)
                        .foregroundColor(.red)
                        .bold()
                        .padding()
                }

                Button {
                    saveUser()
                } label: {
                    Text("Skapa användare")
                        .font(.custom("Roboto-Medium", size: 18))
                        .foregroundColor(.darkGreen)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 20)

                Spacer()

                HStack {

                    Button {
                        Task {
                            onPreviousStep()
                        }
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.darkGreen)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }

                    Spacer()
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 20)

            }
        }
    }

    private func saveAndProceed() {
        if onboardingViewModel.errorMessage.isEmpty {
            saveUser()
        }

    }
}

#Preview("Swedish") {
    OnboardingSummaryView(saveUser: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())

}

#Preview("English") {
    OnboardingSummaryView(saveUser: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())
        .environment(\.locale, Locale(identifier: "ENG"))

}
