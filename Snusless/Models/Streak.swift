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
    var checkedinDays: [Date]
    
    init(checkedinDays: [Date] = []) {
        self.checkedinDays = checkedinDays
    }
}
