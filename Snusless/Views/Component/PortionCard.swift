//
//  PortionCard.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-06-02.
//

import SwiftUI

struct PortionsCard: View {
 
    let dosor: Double
    let portionsPerDosa: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Dagens Portioner")
                .font(.custom("Roboto-Medium", size: 16))
                .foregroundColor(.secondary)
            
            // Double*Int//
            Text("\(Int(dosor * Double(portionsPerDosa))) portioner")
                .font(.custom("Roboto-Bold", size: 24))
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.lightGreen)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 20)
    }
}


#Preview {
    PortionsCard(dosor: 1.5, portionsPerDosa: 20)
}
