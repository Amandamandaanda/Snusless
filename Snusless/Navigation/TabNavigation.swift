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
            VStack {
                Group {
                    switch selectedTab {
                    case .home:
                        HomeView()
                            .transition(.move(edge: .leading))
                    case .profile:
                        EditProfileView()
                            .transition(.move(edge: .leading))
                    }
                }
                .frame(maxHeight: .infinity)
                .animation(.easeInOut, value: selectedTab)
                
                CustomTabBarView(selectedTab: $selectedTab)

            }
        }
      
        
        
    }
}

#Preview {
    NavigationStack {
        TabNavigation(selectedTab: .constant(.home))
    }
}
