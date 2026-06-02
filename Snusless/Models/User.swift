//
//  User.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-18.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var numberOfDosor: Int
    var pricePerDosa: Double
    var portionsPerDosa: Int
    var savingsGoal: Int
    var startDate: Date
    var streak: Streak
    var longestStreak: Int
    var totalSaved: Double
    var dayOfLostStreak: Date?
    
    init(name: String, numberOfDosor: Int, pricePerDosa: Double, portionsPerDosa: Int, savingsGoal: Int, startDate: Date, streak: Streak = Streak(), longestStreak: Int = 0, totalSaved: Double = 0, dayOfLostStreak: Date? = nil) {
        
        self.name = name
        self.numberOfDosor = numberOfDosor
        self.pricePerDosa = pricePerDosa
        self.startDate = startDate
        self.portionsPerDosa = portionsPerDosa
        self.savingsGoal = savingsGoal
        self.streak = streak
        self.longestStreak = longestStreak
        self.totalSaved = totalSaved
        self.dayOfLostStreak = dayOfLostStreak
   
    }
}
