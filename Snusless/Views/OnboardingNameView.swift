//
//  NameView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-18.
//

import SwiftUI

struct OnboardingNameView: View {
    
    @Environment(OnboardingViewModel.self) private var onboardingViewModel

    var body: some View {
        @Bindable var onboardingVM = onboardingViewModel
        
        VStack(alignment: .center, spacing: 16) {
            Spacer()

            Text("Välkommen!")
                .font(.title)
                .foregroundStyle(.white)
                .bold()
                .padding()

            Text("Vänligen skriv ditt namn för att börja")
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .padding()

            TextField("Ditt namn", text: $onboardingVM.name)
                .bold()
                .padding()
                .foregroundStyle(.white)
                .tint(.white)
                .background {
                    Color(.gray.opacity(0.5))
                }
                .cornerRadius(20)

            Spacer()

            HStack {
                Spacer()
                Button {
                    Task {
                        onboardingViewModel.onboardingState = .onboardingDate
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                            .foregroundStyle(onboardingViewModel.name.isEmpty ? .gray : .white)
                    }
                }
                .buttonStyle(.bordered)
                .font(Font.title3.bold())
                .disabled(onboardingViewModel.name.isEmpty)
            }
        }
        .padding()
        .background(.green)
    }
}

#Preview {
    OnboardingNameView()
        .environment(OnboardingViewModel())
}
