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
                .font(.custom("Roboto-Bold", size: 22))
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
                    Color(.white.opacity(0.3))
                }
                .cornerRadius(20)
            
            Text("Valt datum: \(onboardingViewModel.startDate.formatted(.dateTime.day().month(.wide).year().locale(Locale(identifier: "sv_SE"))))")
                .foregroundStyle(.white)
                .font(.custom("Roboto-Bold", size: 18))
            
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
                
                Button {
                    Task {
                        onNextStep()
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.darkGreen)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.bottom, 10)
        }
        .padding(.horizontal, 20)
        .background(.lightGreen)
    }
}

#Preview("Swedish") {
    OnboardingDateView(onNextStep: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())
}

#Preview("English") {
    OnboardingDateView(onNextStep: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())
        .environment(\.locale, Locale(identifier: "ENG"))
}
