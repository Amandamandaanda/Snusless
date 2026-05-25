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
                            
                            Text("\(users.first?.name ?? String(localized: "Ingen användare hittad"))!")
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
                            Text(user.streak.isCompletedToday ? LocalizedStringKey("Ångra dag") : LocalizedStringKey("Jag klarade dagen!"))
                                .font(.custom("Roboto-Medium", size: 18))
                                .bold()
                                .foregroundColor(.white)
                                
                                .padding()
                                .background(user.streak.isCompletedToday ? .errorRed : .darkGreen)
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

#Preview("Swedish") {
    HomeView()
        .modelContainer(for: User.self, inMemory: true)
}

#Preview("English") {
    HomeView()
        .modelContainer(for: User.self, inMemory: true)
        .environment(\.locale, Locale(identifier: "ENG"))
}


