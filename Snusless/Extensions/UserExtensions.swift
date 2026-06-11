//
//  UserSaving.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-05-19.
//

import Foundation

import Foundation

extension User {
    
    func calculateSavings(since startDate: Date) -> Double {
        let calendar = Calendar.current

        let days = calendar.dateComponents([.day], from: startDate, to: Date()).day ?? 0

        return Double(self.numberOfDosor) * self.pricePerDosa * Double(days)
    }
    
    var dailySavings: Double {
        return Double(self.numberOfDosor) * self.pricePerDosa
    }
    
    func calculatePortions() -> Double {
        return Double(self.numberOfDosor) * Double(self.portionsPerDosa) * Double(self.streak.currentStreak)
    }
    
    // Calculation for ProgressView
    var progressFraction: Double {
        guard self.savingsGoal > 0 else { return 0 }
        return min(self.totalSaved / Double(self.savingsGoal), 1.0)
    }
}
