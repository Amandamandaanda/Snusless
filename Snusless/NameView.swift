//
//  NameView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-18.
//

import SwiftUI

struct NameView: View {
    @State private var name: String = ""
    @State private var nameSaved: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()
            
            Text("Vänligen skriv ditt namn för att börja!")
                .font(.subheadline)
                .bold()
                .padding()
            TextField("Ditt namn", text: $name)
                .padding()
                .background {
                    Color(.blue.opacity(0.1))
                }
                .cornerRadius(20)
            Button {
                Task {
                    nameSaved.toggle()
                }
            } label: {
                HStack {
                    Text("Spara")
                        .padding(.vertical, 8)
                    
                }
            }
            .foregroundStyle(.blue.opacity(0.8))
            .buttonStyle(.bordered)
            .font(Font.title3.bold())
            
            Spacer()
            
            HStack {
                
                Spacer()
                Button {
                    Task {
                        
                    }
                } label: {
                    HStack {
                        Text("Fortsätt")
                            .padding(.vertical, 8)
                        Image(systemName: "arrow.right")
                        
                    }
                }
                .buttonStyle(.borderedProminent)
                .font(Font.title3.bold())
                .disabled(nameSaved ? false : true)
            }
        }
        .padding()
    }
}

#Preview {
    NameView()
}
