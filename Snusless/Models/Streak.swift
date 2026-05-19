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
    var completedDays: [Date]
    
    init(completedDays: [Date] = []) {
        self.completedDays = completedDays
    }
}
