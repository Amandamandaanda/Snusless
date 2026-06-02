//
//  SavingsCard.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-22.
//

import SwiftUI

struct SavingsCard: View {
    let days: Int
    let savedAmount: Double
    let savingsGoal: Int
    let longestStreak: Int

    // Calculation for ProgressView
    private var progressFraction: Double {
        guard savingsGoal > 0 else { return 0 }
        return min(savedAmount / Double(savingsGoal), 1.0)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.lightGreen)

            Circle()
                .stroke(
                    .white.opacity(0.2),
                    style: StrokeStyle(lineWidth: 10, dash: [100, 100])
                )
                .frame(width: 180, height: 180)
                .position(x: 75, y: 142)

            VStack {
                if longestStreak > 0 {
                    VStack {
                        Text("Längsta streak")
                            .font(.custom("Afacad-Regular", size: 16))
                            .foregroundColor(.white)
                        Text("\(longestStreak) dagar")
                            .font(.custom("Afacad-Bold", size: 18))
                            .foregroundColor(.darkGreen)
                    }
                    .padding(.top, 10)
                }

                Spacer()

                HStack {
                    VStack(alignment: .leading, spacing: -10) {
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Text("\(days)")
                                .font(.custom("Afacad-Bold", size: 40))
                                .foregroundColor(.white)

                            Text("dagar")
                                .font(.custom("Afacad-Regular", size: 20))
                                .foregroundColor(.white)
                        }

                        Text("utan snus")
                            .font(.custom("Afacad-Regular", size: 20))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    VStack(alignment: .leading, spacing: -8) {
                        Text("Du har sparat")
                            .font(.custom("Afacad-Regular", size: 20))
                            .foregroundColor(.white)

                        HStack(alignment: .firstTextBaseline, spacing: 2) {
                            Text(String(format: "%.0f", savedAmount))
                                .font(.custom("Afacad-Bold", size: 40))
                                .foregroundColor(.white)

                            Text("kr")
                                .font(.custom("Afacad-Regular", size: 24))
                                .foregroundColor(.white)

                        }
                    }
                }
                .padding(.horizontal, 30)

                Spacer()

                // ProgressView
                VStack(spacing: 8) {
                    HStack {
                        Text("\(Int(progressFraction * 100))%")
                            .font(.custom("Afacad-Bold", size: 14))
                            .foregroundColor(.white)

                        Spacer()

                        Text("Mål: \(savingsGoal) kr")
                            .font(.custom("Afacad-Regular", size: 14))
                            .foregroundColor(.white.opacity(0.8))
                    }

                    ProgressView(value: progressFraction)
                        .tint(
                            progressFraction >= 1.0
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
        .clipped()
        .frame(height: 220)
        .frame(width: 380)
        .padding(.horizontal, 20)
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)

    }
}

#Preview {
    SavingsCard(
        days: 20,
        savedAmount: 10000,
        savingsGoal: 10000,
        longestStreak: 25
    )
}
