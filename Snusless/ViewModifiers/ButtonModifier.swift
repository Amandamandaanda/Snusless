//
//  ButtonModifier.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-28.
//

import Foundation
import SwiftUI

struct ButtonModifier: ViewModifier {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .darkGreen
    func body(content: Content) -> some View {
        content
            .font(.custom("Roboto-Medium", size: 18))
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(15)
    }
}
