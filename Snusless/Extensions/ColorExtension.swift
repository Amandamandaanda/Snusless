//
//  ColorExtension.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    
    // Direct color definition (alternative to Asset Catalog)
    static let emojiYellow = Color(red: 240/255, green: 200/255, blue: 40/255)
}

struct ColorTheme {
    let lightGreen = Color("LightGreen")
    let darkGreen = Color("DarkGreen")
    let errorRed = Color("ErrorRed")
    let emojiYellow = Color("EmojiYellow")
}
