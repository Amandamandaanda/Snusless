//
//  OnboardingSummaryView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-21.
//

import SwiftUI
import SwiftData

struct OnboardingSummaryView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            Color(.systemGreen)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                Text("Sammanfattning")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 20) {
                    SummaryRow(title: "Namn", value: onboardingViewModel.name)
                    
                    SummaryRow(title: "Startdatum", value: formatDate(onboardingViewModel.startDate))
                    
                    SummaryRow(title: "Dosor per dag", value: "\(onboardingViewModel.numberOfDosor)")
                    
                    SummaryRow(title: "Portioner per dosa", value: "\(onboardingViewModel.portionsPerDosa)")
                    
                    SummaryRow(title: "Pris per dosa", value: String(format: "%.2f kr", onboardingViewModel.pricePerDosa))
                    
                    SummaryRow(title: "Sparmål", value: "\(onboardingViewModel.savingGoal) kr")
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
                    onboardingViewModel.saveUser(context: modelContext)
                } label: {
                    Text("Skapa användare")
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
            }
        }
    }
    
    private func isActive(_ state: OnboardingState) -> Bool {
        onboardingViewModel.onboardingState == state
    }
    
    private func canNavigateTo(_ state: OnboardingState) -> Bool {
        switch state {
        case .onboardingName:
            return true
        case .onboardingDate:
            return onboardingViewModel.isNameValid
        case .onboardingDosor:
            return onboardingViewModel.isNameValid
        case .onboardingEconomy:
            return onboardingViewModel.isDosorValid
        case .onboardingSummary:
            return true
        case .onboardingDone:
            return false
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "sv_SE")
        return formatter.string(from: date)
    }
}

struct SummaryRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
            Spacer()
            Text(value)
                .font(.body)
                .bold()
                .foregroundColor(.white)
        }
    }
}

#Preview {
    OnboardingSummaryView()
        .environment(OnboardingViewModel())
}
