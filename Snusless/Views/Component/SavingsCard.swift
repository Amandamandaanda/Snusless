//
//  SavingsCard.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-22.
//

import SwiftUI

struct SavingsCard: View {
    let days: Int
    let savedAmount: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.lightGreen
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            
            GeometryReader { geometry in
                Circle()
                    .stroke(.white.opacity(0.2), style: StrokeStyle(lineWidth: 10, dash: [100, 100]))
                    .frame(width: 180, height: 180)
                    .position(x: 70, y: 150 )
            }
            

            HStack() {

                VStack(alignment: .leading, spacing: -10) {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("\(days)")
                            .font(.custom("Afacad-Bold", size: 40))
                            .foregroundColor(.white)
                        
                        Text("dagar")
                            .font(.custom("Afacad-Regular", size: 20))
                            .foregroundColor(.white)
                    }
                    
                    Text("utan snus")
                        .font(.custom("Afacad-Regular", size: 20))
                        .foregroundColor(.white)
                }
  
                
                Spacer()
                

                
                VStack(alignment: .leading, spacing: -8) {
                    Text("Du har sparat")
                        .font(.custom("Afacad-Regular", size: 20))
                        .foregroundColor(.white)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text(String(format: "%.0f", savedAmount))
                            .font(.custom("Afacad-Bold", size: 40))
                            .foregroundColor(.white)
                        
                        Text("kr")
                            .font(.custom("Afacad-Regular", size: 24))
                            .foregroundColor(.white)
                        
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 40)
        }
        .clipped()
        .frame(height: 220)
        .frame(width: 380)
        .padding(.horizontal, 20)
    }
}

#Preview {
    SavingsCard(days: 35, savedAmount: 3000)
}
