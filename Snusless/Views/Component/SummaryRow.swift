//
//  SummaryRow.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-21.
//

import SwiftUI

struct SummaryRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("Roboto-Light", size: 16))
                .foregroundColor(.white.opacity(0.9))
            Spacer()
            Text(value)
                .font(.custom("Roboto-Bold", size: 16))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SummaryRow(title: "Namn", value: "Berit")
        .background(.green)
}
