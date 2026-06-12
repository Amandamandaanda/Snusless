//
//  PortionCard.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-06-02.
//

import SwiftUI

struct StatisticsCard: View {
 
    
    let title: String
    let description: String
    var foregroundColorTitle: Color = .darkGreen

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom("Roboto-Medium", size: 16))
                .foregroundColor(foregroundColorTitle)
            
            Text(description)
                .font(.custom("Roboto-Bold", size: 18))
                .foregroundColor(.black)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.lightGreen.opacity(0.1))
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(foregroundColorTitle, lineWidth: 2))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 20)
    }
}


#Preview {
    StatisticsCard(title: "Du har inte tagit", description: "15 portioner snus", foregroundColorTitle: Color.darkGreen)
}
