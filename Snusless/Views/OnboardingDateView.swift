//
//  OnboardingDateView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-19.
//

import SwiftUI

struct OnboardingDateView: View {
    
    @Environment(OnboardingViewModel.self) private var onboardingViewModel

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
                        onboardingViewModel.onboardingState = .onboardingName
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.bordered)
                .font(Font.title3.bold())
                
                Spacer()
                Button {
                    Task {
                        // Just for now until rest of onboarding is done!
                        onboardingViewModel.onboardingState = .onboardingDone
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.bordered)
                .font(Font.title3.bold())
            }
        }
        .padding()
        .background(.green)
    }
}

#Preview {
    OnboardingDateView()
        .environment(OnboardingViewModel())
}
