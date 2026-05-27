//
//  ProfileView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-26.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
        @Environment(\.modelContext) private var modelContext
        @Environment(\.dismiss) private var dismiss
        
        @State private var editName: String = ""
        @State private var editDosor: Int = 0
        @State private var editPrice: Double = 0.0
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
            .environment(OnboardingViewModel())

    }
    
}
