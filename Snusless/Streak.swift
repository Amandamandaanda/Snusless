//
//  Streak.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-18.
//

import SwiftData
import Foundation

@Model
class Streak {
    var currentStreak: [Date] = []
    
    init(currentStreak: [Date]) {
        self.currentStreak = currentStreak
    }
}
