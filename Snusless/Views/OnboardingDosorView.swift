//
//  OnboardingDosorView.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-05-19.
//

import SwiftUI

struct OnboardingDosorView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel

    @State private var portionCount: Double = 20.0

    var onNextStep: () -> Void
    var onPreviousStep: () -> Void

    var body: some View {
        @Bindable var onboardingVM = onboardingViewModel

        ZStack {
            Color(.lightGreen)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                VStack(spacing: 15) {
                    Text("Hur många snusdosor\nanvänder du per dag?")
                        .font(.custom("Roboto-Bold", size: 22))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    TextField(
                        "",
                        value: $onboardingVM.numberOfDosor,
                        format: .number,
                        prompt: Text("Antal")
                    )
                    .keyboardType(.numberPad)
                    .modifier(OnboardingTextFieldModifier())
                }

                Spacer().frame(height: 20)

                VStack(spacing: 15) {
                    Text("Hur många portioner\när det i en snusdosa?")
                        .font(.custom("Roboto-Bold", size: 22))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Text("\(Int(onboardingViewModel.portionsPerDosa))")
                        .font(.custom("Roboto-Light", size: 20))
                        .bold()
                        .foregroundColor(.white)

                    Slider(value: $portionCount, in: 10...30, step: 1)
                        .accentColor(.white)
                        .padding(.horizontal, 40)
                        .onChange(of: portionCount) { _, newValue in
                            onboardingViewModel.portionsPerDosa = Int(newValue)
                        }

                    HStack {
                        Text("10")
                        Spacer()
                        Text("30")
                    }
                    .foregroundColor(.white.opacity(0.6))
                    .font(.custom("Roboto-Light", size: 14))
                    .padding(.horizontal, 40)
                }

                if !onboardingViewModel.errorMessage.isEmpty {
                    Text(onboardingViewModel.errorMessage)
                        .foregroundColor(.red)
                }

                Spacer()

                HStack {
                    Button {
                        Task {
                            onPreviousStep()
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .modifier(ArrowButtonModifier())
                    }

                    Spacer()

                    Button {
                        Task {
                            onNextStep()
                        }
                    } label: {
                        Image(systemName: "arrow.right")
                            .modifier(
                                ArrowButtonModifier(
                                    backgroundColor: onboardingViewModel
                                        .isDosorValid
                                        ? Color.white : Color.white.opacity(0.4)
                                )
                            )
                    }
                    .disabled(!onboardingViewModel.isDosorValid)
                }
            }
            .padding(20)
        }
    }

    private func saveAndProceed() {
        onboardingViewModel.portionsPerDosa = Int(portionCount)
        if onboardingViewModel.errorMessage.isEmpty {
            onNextStep()
        }
    }
}

#Preview("Swedish") {
    OnboardingDosorView(onNextStep: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())
}

#Preview("English") {
    OnboardingDosorView(onNextStep: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())
        .environment(\.locale, Locale(identifier: "ENG"))
}
