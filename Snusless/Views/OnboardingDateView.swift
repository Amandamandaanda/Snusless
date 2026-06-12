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
        ZStack {
            Color(.lightGreen)
                .ignoresSafeArea()

            VStack(alignment: .center, spacing: 16) {
                Spacer()

                Text("Vilket datum slutade du snusa?")
                    .font(.custom("Roboto-Bold", size: 22))
                    .foregroundStyle(.white)
                    .bold()
                    .padding()

                DatePicker(
                    "Startdatum",
                    selection: $onboardingVM.startDate,
                    in: ...Date(),
                    displayedComponents: .date
                )
                .padding(.horizontal)
                .environment(\.colorScheme, .dark)
                .environment(\.locale, .current)
                .datePickerStyle(GraphicalDatePickerStyle())
                .tint(.white)
                .background {
                    Color(.white.opacity(0.3))
                }
                .cornerRadius(20)

                Text(
                    "Valt datum: \(onboardingViewModel.startDate.formattedLong())"
                )
                .foregroundStyle(.white)
                .font(.custom("Roboto-Bold", size: 18))

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
                            .modifier(ArrowButtonModifier())
                    }
                }
            }
            .padding(20)
        }
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
