//
//  OnboardingDateView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-19.
//

import SwiftUI

struct OnboardingDateView: View {
    
    @Bindable var viewModel: OnboardingViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()

            Text("Vilket datum slutade du snusa?")
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .padding()

            DatePicker("Startdatum", selection: $viewModel.startDate, in: ...Date(), displayedComponents: .date)
                .padding(.horizontal)
                .environment(\.colorScheme, .dark)
                .environment(\.locale, Locale(identifier: "sv_SE"))
                .datePickerStyle(GraphicalDatePickerStyle())
                .tint(.white)
                .background {
                    Color(.gray.opacity(0.5))
                }
                .cornerRadius(20)
            
            Text("Valt datum: \(viewModel.startDate.formatted(.dateTime.day().month(.wide).year().locale(Locale(identifier: "sv_SE"))))")
                .foregroundStyle(.white)
                .bold()
            
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
    OnboardingDateView(viewModel: OnboardingViewModel())
}
