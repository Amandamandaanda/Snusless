//
//  UserSaving.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-05-19.
//

import Foundation

import Foundation

extension User {
   
    func calculateSavings(forDays days: Int) -> Double {
        return Double(self.numberOfDosor) * self.pricePerDosa * Double(days)
    }
    
    var dailySavings: Double {
        return Double(self.numberOfDosor) * self.pricePerDosa
    }
    
    func calculatePortions() -> Double {
        return Double(self.numberOfDosor) * Double(self.portionsPerDosa) * Double(self.streak.currentStreak)
    }
}
