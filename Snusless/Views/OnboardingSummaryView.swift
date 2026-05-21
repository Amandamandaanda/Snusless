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
    
    var saveUser: () -> Void
    var onPreviousStep: () -> Void
    
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
                    saveUser()
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
                                .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))
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
    
    
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "sv_SE")
        return formatter.string(from: date)
    }
    
    private func saveAndProceed() {
            if onboardingViewModel.errorMessage.isEmpty {
                saveUser()
            }
        
    }
}



#Preview {
    OnboardingSummaryView(saveUser: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())
}
