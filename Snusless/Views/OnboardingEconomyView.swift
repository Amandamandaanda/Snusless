//
//  OnboardingEconomyView.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-05-19.
//

import SwiftUI

struct OnboardingEconomyView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel

    var onNextStep: () -> Void
    var onPreviousStep: () -> Void

    var body: some View {
        @Bindable var onboardingVM = onboardingViewModel

        ZStack {
            Color(.lightGreen)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                VStack(spacing: 12) {
                    Text("Vad kostar en snusdosa?")
                        .font(.custom("Roboto-Bold", size: 22))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    TextField(
                        "",
                        value: $onboardingVM.pricePerDosa,
                        format: .number,
                        prompt: Text("40kr")
                    )
                    .modifier(TextFieldModifier(fontSize: 18, frameWidth: 140, textAlignment: .center))
                }

                VStack(spacing: 12) {
                    Text("Sparmål:")
                        .font(.custom("Roboto-Bold", size: 22))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    TextField(
                        "",
                        value: $onboardingVM.savingGoal,
                        format: .number,
                        prompt: Text("1000kr")
                    )
                    .modifier(TextFieldModifier(fontSize: 18, frameWidth: 140, textAlignment: .center))
                }

                if !onboardingViewModel.errorMessage.isEmpty {
                    Text(onboardingViewModel.errorMessage)
                        .foregroundColor(.red)
                }

                if (!onboardingViewModel.isValidPrice
                    && (onboardingViewModel.pricePerDosa ?? 0) > 0)
                    || (!onboardingViewModel.isValidGoal
                        && (onboardingViewModel.savingGoal ?? 0) > 0)
                {
                    Text("Vänligen fyll i ett giltigt pris och sparmål.")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
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
                                        .canProceed
                                        ? Color.white : Color.white.opacity(0.4)
                                )
                            )
                    }
                    .disabled(!onboardingViewModel.canProceed)
                }
            }
            .padding(20)
        }
    }

}

#Preview("Swedish") {
    OnboardingEconomyView(onNextStep: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())
}

#Preview("English") {
    OnboardingEconomyView(onNextStep: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())
        .environment(\.locale, Locale(identifier: "ENG"))

}
