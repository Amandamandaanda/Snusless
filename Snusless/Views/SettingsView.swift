//
//  SettingsView.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Query private var users: [User]
    
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    @State private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Button {
                    
                } label: {
                    HStack {
                        Text("Rensa data")
                            .foregroundStyle(.red)
                        
                        Spacer()
                        
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                            .background(Color.red.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("Inställningar")
            
            }
        }
      
    }
}


#Preview {
    SettingsView()
}
