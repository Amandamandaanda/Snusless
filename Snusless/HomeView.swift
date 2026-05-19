//
//  HomeView.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-18.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Query private var streaks: [Streak]
    
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
                    
                    if let streak = streaks.first{
                        VStack(spacing: 20) {
                            Text("\(streak.currentStreak)")
                                .font(.system(size: 56, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Text("dagar snusfri")
                                .font(.title3)
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .background(
                            LinearGradient(
                                colors: [.green.opacity(0.8), .green],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .padding(.horizontal)
                        Button {
                            viewModel.checkToday(streak: streak, context: modelContext)
                        } label: {
                            Text(streak.isCompletedToday ? "Ångra dag" : "Jag klarade dagen!")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.horizontal)
                        
                    } else {
                        Button("Dag 1 börjar nu") {
                            let newStreak = Streak()
                            modelContext.insert(newStreak)
                            try? modelContext.save()
                        }
                        .padding()
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Streak.self, inMemory: true)
}
