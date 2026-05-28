//
//  TextFieldModifier.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-28.
//

import Foundation
import SwiftUI

struct OnboardingTextFieldModifier: ViewModifier {
    var fontSize: CGFloat = 18
    var keyboardType: UIKeyboardType = .decimalPad
    var backgroundColor: Color = .white
    var foregroundColor: Color = .black
    var frameWidth: CGFloat = 140
    
    func body(content: Content) -> some View {
        
        content
            .font(.custom("Roboto-Light", size: fontSize))
            .keyboardType(keyboardType)
            .multilineTextAlignment(.center)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
            .frame(width: frameWidth)
        
    }
    
}

struct EditProfileViewModifier: ViewModifier {
    var keyboardType: UIKeyboardType = .decimalPad

    func body(content: Content) -> some View {
        content
            .padding()
            .font(.custom("Roboto-Light", size: 18))
            .keyboardType(keyboardType)
            .background(.lightGreen.opacity(0.1))
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(.darkGreen, lineWidth: 2))
            .foregroundColor(.black)
            .cornerRadius(10)
            .padding(.bottom, 16)

    }
}


   
