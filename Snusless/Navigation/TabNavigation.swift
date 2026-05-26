//
//  TabNavigation.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-26.
//

import SwiftUI

struct TabNavigation: View {
    @Binding var selectedTab: TabSelection
    
    var body: some View {
        NavigationStack {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                        .transition(.move(edge: .leading))
                case .profile:
                    ProfileView()
                        .transition(.move(edge: .leading))
                }
            }
            .animation(.easeInOut, value: selectedTab)
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button {
                    selectedTab = .home
                } label: {
                    VStack {
                        Image(systemName: selectedTab == .home ? "house.fill" : "house")
                            .padding(.bottom, 2)
                        Text("Hem")
                            .font(.custom("Roboto-Regular", size: 12))
                    }
                }
                .foregroundColor(selectedTab == .home ? .darkGreen : .secondary)
                .padding(10)
                
                Button {
                    selectedTab = .profile
                } label: {
                    VStack {
                        Image(systemName: selectedTab == .profile ? "person.fill" : "person")
                            .padding(.bottom, 2)
                        Text("Profil")
                            .font(.custom("Roboto-Regular", size: 12))
                    }
                }
                .foregroundColor(selectedTab == .profile ? .darkGreen : .secondary)
                .padding(10)
               
                Spacer()
                
            }
            
        }
      
        
        
    }
}

#Preview {
    NavigationStack {
        TabNavigation(selectedTab: .constant(.home))
    }
}
