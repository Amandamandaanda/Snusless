//
//  ProfileView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gear")
                }
         
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()

    }
    
}
