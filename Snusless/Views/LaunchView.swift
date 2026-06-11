//
//  LaunchView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-25.
//

import SwiftUI
import SwiftData

struct LaunchView: View {
    @State private var isLoading = true
    
    var body: some View {
        if isLoading {
            ZStack {
                Color.theme.lightGreen
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image("snusless")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 26))
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

                    Text("Snusless")
                        .font(.custom("Roboto-Bold", size: 48))
                        .foregroundColor(.white)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    Text("Utvecklad av: Grupp 2")
                        .font(.custom("Roboto-Bold", size: 14))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.bottom, 40)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
            
        } else {
            RootNavigation()
        }
    }
}

#Preview {
    LaunchView()
        .modelContainer(for: [User.self, Streak.self], inMemory: true)
}
