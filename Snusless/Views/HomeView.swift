//
//  HomeView.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-18.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Query private var users: [User]
    
    @Environment(\.modelContext)
    private var modelContext
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack(spacing: 24){
                    Text("Snusless")
                        .font(.largeTitle)
                        .padding(.top)
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                        .foregroundStyle(.red)
                        .font(.caption)
                    }
                    
                    if let user = users.first{
                    
                        VStack(spacing: 20) {
                            Text("\(user.streak.currentStreak)")
                                .font(.system(size: 56, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Text("dagar snusfri")
                                .font(.title3)
                                .foregroundStyle(.white)
                            
                            Text("Du har sparat \(Int(user.calculateSavings(forDays: user.streak.currentStreak))) kr")
                                .font(.title3)
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .background(.green)
                        
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .padding(.horizontal)
                        Button {
                            viewModel.checkToday(user: user, context: modelContext)
                        } label: {
                            Text(user.streak.isCompletedToday ? "Ångra dag" : "Jag klarade dagen!")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.horizontal)
                    } else {
                        Text("Finns ingen användare än")
                    }
                    Spacer()
                }
            }
        }
    }
}


