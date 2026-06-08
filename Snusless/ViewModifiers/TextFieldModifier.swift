//
//  TextFieldModifier.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-28.
//

import Foundation
import SwiftUI

struct TextFieldModifier: ViewModifier {
    var fontSize: CGFloat = 16
    var keyboardType: UIKeyboardType = .decimalPad
    var backgroundColor: Color = .white
    var foregroundColor: Color = .black
    var frameWidth: CGFloat = .infinity
    var textAlignment: TextAlignment = .leading

    func body(content: Content) -> some View {

        content
            .font(.custom("Roboto-Medium", size: fontSize))
            .keyboardType(keyboardType)
            .multilineTextAlignment(textAlignment)
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
            .frame(width: frameWidth)
            .padding(.bottom, 16)

    }

}
