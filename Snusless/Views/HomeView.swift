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
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text("Hej! 👋")
                                .font(.custom("Roboto-Regular", size: 24))
                            Text("\(users.first?.name ?? "Ingen användare hittad")!")
                                .font(.custom("Roboto-Bold", size: 24))
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
                    
                        VStack() {
                            Text("\(user.streak.currentStreak)")
                                .font(.custom("Afacad-Bold", size: 56))
                                .font(.system(size: 56, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Text("dagar snusfri")
                                .font(.custom("Afacad-Regular", size: 24))
                                .foregroundStyle(.white)
                    
                                .cornerRadius(15)
                                .padding(.horizontal, 20)
                            
                            Text("Du har sparat \(Int(user.calculateSavings(forDays: user.streak.currentStreak))) kr")
                                .font(.custom("Afacad-Regular", size: 24))
//                                .font(.title3)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom)
                        .frame(maxWidth: 360)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                        
                        Button {
                            viewModel.checkToday(user: user, context: modelContext)
                        } label: {
                            Text(user.streak.isCompletedToday ? "Ångra dag" : "Jag klarade dagen!")
                                .font(.custom("Roboto-Medium", size: 18))
                                .bold()
                                .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))
                                
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.horizontal, 20)
                    } else {
//                        Text("Finns ingen användare än")
//                            .font(.custom("Afacad-Regular", size: 16))
                        
                    }
                    Spacer()
                }
            }
        }
    }
    
    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("-- \(fontName)")
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: User.self, inMemory: true)
}


