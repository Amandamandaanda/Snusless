//
//  NotificationToggleStyle.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-06-03.
//

import SwiftUI

struct NotificationToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Button{
            configuration.isOn.toggle()
        } label: {
            configuration.label
            
            Spacer()
            
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "bell")
                
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color.lightGreen.opacity(0.1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16)
        )
    }
}
