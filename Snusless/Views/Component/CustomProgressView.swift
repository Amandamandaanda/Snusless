//
//  CustomProgressView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-06-11.
//

import SwiftUI

struct CustomProgressView: View {
    var user: User
    var body: some View {
        // ProgressView
        VStack(spacing: 8) {
            HStack {
                Text("\(Int(user.progressFraction * 100))%")
                    .font(.custom("Afacad-Bold", size: 14))
                    .foregroundColor(.white)

                Spacer()

                Text("Mål: \(user.savingsGoal) kr")
                    .font(.custom("Afacad-Regular", size: 14))
                    .foregroundColor(.white.opacity(0.8))
            }

            ProgressView(value: user.progressFraction)
                .tint(
                    user.progressFraction >= 1.0
                        ? .darkGreen
                        : .white.opacity(0.8)
                )
                .background(.white.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 4))
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 20)
    }
}

#Preview {
    CustomProgressView(user: User(name: "Erik", numberOfDosor: 2, pricePerDosa: 40.0, portionsPerDosa: 22, savingsGoal: 10000, startDate: Date()))
}
