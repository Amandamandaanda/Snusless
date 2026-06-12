//
//  NameView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-18.
//

import SwiftUI

struct OnboardingNameView: View {

    @Environment(OnboardingViewModel.self) private var onboardingViewModel

    var onNextStep: () -> Void

    var body: some View {
        @Bindable var onboardingVM = onboardingViewModel

        ZStack {
            Color(.lightGreen)
                .ignoresSafeArea()

            VStack(alignment: .center, spacing: 24) {
                Spacer()

                Text("Välkommen!")
                    .font(.custom("Roboto-Bold", size: 32))
                    .foregroundStyle(.white)
                    .padding()

                Text("Vänligen skriv ditt namn för att börja")
                    .font(.custom("Roboto-Bold", size: 22))
                    .foregroundStyle(.white)

                TextField("Ditt namn", text: $onboardingVM.name)
                    .modifier(TextFieldModifier(fontSize: 18, keyboardType: .default))
                    .onChange(of: onboardingVM.name) { _, newValue in
                        let filtered = newValue.filter {
                            $0.isLetter || $0.isWhitespace
                        }

                        let limited = String(filtered.prefix(20))
                        onboardingVM.name = limited
                    }

                Spacer()

                HStack {
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
                                        .isNameValid
                                        ? Color.white : Color.white.opacity(0.4)
                                )
                            )
                    }
                    .disabled(!onboardingViewModel.isNameValid)
                }
            }
            .padding(20)
        }
    }
}

#Preview("Swedish") {
    OnboardingNameView(onNextStep: {})
        .environment(OnboardingViewModel())
}

#Preview("English") {
    OnboardingNameView(onNextStep: {})
        .environment(OnboardingViewModel())
        .environment(\.locale, Locale(identifier: "ENG"))

}
