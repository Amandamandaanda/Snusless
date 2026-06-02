//
//  HomeView.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-18.
//

import SwiftData
import SwiftUI

struct HomeView: View {

    @Query private var users: [User]

    @Environment(\.modelContext)
    private var modelContext

    @State private var viewModel = HomeViewModel()
    
    @State private var disableButton = false

    var body: some View {
        
        NavigationStack {
            ZStack {
                VStack(spacing: 24) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hej! 👋")
                                .font(.custom("Roboto-Regular", size: 24))
                                .foregroundColor(.secondary)

                            Text(
                                "\(users.first?.name ?? String(localized: "Ingen användare hittad"))!"
                            )
                            .font(.custom("Roboto-Bold", size: 24))
                            .foregroundColor(.black)
                        }
                        .padding(.top)
                        Spacer()

                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                            .font(.caption)
                    }

                    if let user = users.first {

                        SavingsCard(
                            days: user.streak.currentStreak,
                            savedAmount: user.totalSaved,
                            savingsGoal: user.savingsGoal,
                            longestStreak: user.longestStreak
                        )

                        PortionsCard(
                            dosor: user.numberOfDosor,
                            portionsPerDosa: user.portionsPerDosa
                        )

                        HStack(spacing: 12) {
                            Button {
                                viewModel.checkToday(
                                    user: user,
                                    context: modelContext
                                )
                            } label: {
                                Text("Jag klarade dagen!")
                                .font(.custom("Roboto-Medium", size: 18))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .padding(.horizontal, 10)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .background( disableButton ? .darkGreen.opacity(0.2) :
                                .darkGreen
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .disabled(disableButton ? true : false)

                            Button {
                                viewModel.resetStreak(
                                    user: user,
                                    context: modelContext
                                )
                                
                                disableButton = true
                                user.dayOfLostStreak = Date()
                                
                            } label: {
                                Text("Jag tog en snus")
                                    .font(.custom("Roboto-Medium", size: 18))
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity)
                            .background(.errorRed)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            )
                        }
                        .padding(20)
                    }
                    Spacer()
                }
            }
            .padding(20)
            .onAppear {
                // Check if streak is broken when view appears
                if let user = users.first {
                    viewModel.checkAndResetStreakIfBroken(
                        user: user,
                        context: modelContext
                    )
                    
                    if user.dayOfLostStreak != Calendar.current.startOfDay(for: Date()) {
                        disableButton = false
                    }
                }
            }
        }
    }

    // Too see names of fonts to be able to use customs
    //    init() {
    //        for familyName in UIFont.familyNames {
    //            print(familyName)
    //
    //            for fontName in UIFont.fontNames(forFamilyName: familyName) {
    //                print("-- \(fontName)")
    //            }
    //        }
    //    }
}

#Preview("Swedish") {
    HomeView()
        .modelContainer(for: User.self, inMemory: true)
}

#Preview("English") {
    HomeView()
        .modelContainer(for: User.self, inMemory: true)
        .environment(\.locale, Locale(identifier: "ENG"))
}
