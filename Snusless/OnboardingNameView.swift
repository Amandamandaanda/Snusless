//
//  NameView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-18.
//

import SwiftUI

struct OnboardingNameView: View {
    
    @Bindable var viewModel: OnboardingViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()

            Text("Välkommen!")
                .font(.title)
                .foregroundStyle(.white)
                .bold()
                .padding()

            Text("Vänligen skriv ditt namn för att börja")
                .font(.headline)
                .foregroundStyle(.white)
                .bold()
                .padding()

            TextField("Ditt namn", text: $viewModel.name)
                .bold()
                .padding()
                .background {
                    Color(.white.opacity(0.5))
                }
                .cornerRadius(20)

            Spacer()

            HStack {
                Spacer()
                Button {
                    Task {

                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                            .foregroundStyle(viewModel.name.isEmpty ? .gray : .white)
                    }
                }
                .buttonStyle(.bordered)
                .font(Font.title3.bold())
                .disabled(viewModel.name.isEmpty)
            }
        }
        .padding()
        .background(.green)
    }
}

#Preview {
    OnboardingNameView(viewModel: OnboardingViewModel())
}
