//
//  ArrowButtonModifier.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-29.
//

import Foundation
import SwiftUI

struct ArrowButtonModifier: ViewModifier {
    var backgroundColor: Color = .white
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .bold()
            .foregroundColor(.darkGreen)
            .padding()
            .background(backgroundColor)
            .clipShape(Circle())
    }
}
