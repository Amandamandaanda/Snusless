//
//  OnboardingDateView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-19.
//  Updated for integration.
//

import SwiftUI

struct OnboardingDateView: View {
    
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    
    var onNextStep: () -> Void
    var onPreviousStep: () -> Void

    var body: some View {
        @Bindable var onboardingVM = onboardingViewModel
        
        VStack(alignment: .center, spacing: 16) {
            Spacer()

            Text("Vilket datum slutade du snusa?")
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .padding()

            DatePicker("Startdatum", selection: $onboardingVM.startDate, in: ...Date(), displayedComponents: .date)
                .padding(.horizontal)
                .environment(\.colorScheme, .dark)
                .environment(\.locale, Locale(identifier: "sv_SE"))
                .datePickerStyle(GraphicalDatePickerStyle())
                .tint(.white)
                .background {
                    Color(.gray.opacity(0.5))
                }
                .cornerRadius(20)
            
            Text("Valt datum: \(onboardingViewModel.startDate.formatted(.dateTime.day().month(.wide).year().locale(Locale(identifier: "sv_SE"))))")
                .foregroundStyle(.white)
                .bold()
            
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
                
                Button {
                    Task {
                        onNextStep()
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.bottom, 10)
        }
        .padding(.horizontal, 20)
        .background(.green)
    }
}

#Preview {
    OnboardingDateView(onNextStep: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())
}
