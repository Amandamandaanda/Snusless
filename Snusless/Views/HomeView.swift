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
                Color.green
                    .ignoresSafeArea()
                
                VStack(spacing: 24){
                    Text("Snusless")
                        .font(.largeTitle)
                        .padding(.top)
                        .foregroundStyle(.white)
                    
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
                                .padding()
                    
                                .cornerRadius(15)
                                .padding(.horizontal, 20)
                            
                            Text("Du har sparat \(Int(user.calculateSavings(forDays: user.streak.currentStreak))) kr")
                                .font(.title3)
                                .foregroundStyle(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                        
                        Button {
                            viewModel.checkToday(user: user, context: modelContext)
                        } label: {
                            Text(user.streak.isCompletedToday ? "Ångra dag" : "Jag klarade dagen!")
                                .font(.headline)
                                .bold()
                                .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))
                                
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.horizontal, 20)
                    } else {
                        Text("Finns ingen användare än")
                    }
                    Spacer()
                }
            }
        }
    }
}


