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
//                Color.green
//                    .ignoresSafeArea()
                
                VStack(spacing: 24){
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text("Hej! 👋")
                                .font(.custom("Roboto-Regular", size: 24))
                                .foregroundColor(.secondary)
                            Text("\(users.first?.name ?? "Ingen användare hittad")!")
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
                    
                       
                    
                    if let user = users.first{
                        
                        SavingsCard(days: user.streak.currentStreak, savedAmount: user.calculateSavings(forDays: user.streak.currentStreak))
            
                        
                        Button {
                            viewModel.checkToday(user: user, context: modelContext)
                        } label: {
                            Text(user.streak.isCompletedToday ? "Ångra dag" : "Jag klarade dagen!")
                                .font(.custom("Roboto-Medium", size: 18))
                                .bold()
                                .foregroundColor(.white)
                                
                                .padding()
                                .background(LinearGradient(
                                    colors: [
                                        Color(red: 0.45, green: 0.75, blue: 0.55),
                                        Color(red: 0.35, green: 0.65, blue: 0.45)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.horizontal, 20)
                    }
                    Spacer()
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

#Preview {
    HomeView()
        .modelContainer(for: User.self, inMemory: true)
}


