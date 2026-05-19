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
                VStack(spacing: 16){
                    Text("Snusless")
                        .font(.largeTitle)
                        .padding(.top)
                    
                    if let error = viewModel.errorMessage {
                        
                        Text(error)
                        .foregroundStyle(.red)
                        .font(.caption)
                    }
                    
                    if let streak = streaks.first{
                        Text("Du har varit \(streak.currentStreak) dagar snusfri")
                            .font(.title)
                        
                        Button {
                            viewModel.checkToday(streak: streak, context: modelContext)
                        } label: {
                            Text(streak.isCompletedToday ? "Ångra dag" : "Jag klarade dagen!")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    } else {
                        Button("Dag 1 börjar nu") {
                            let newStreak = Streak()
                            modelContext.insert(newStreak)
                            try? modelContext.save()
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Streak.self, inMemory: true)
}
