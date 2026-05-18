//
//  HomeView.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-18.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack(spacing: 16){
                    Text("Snusless")
                        .font(.largeTitle)
                        .padding(.top)
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
