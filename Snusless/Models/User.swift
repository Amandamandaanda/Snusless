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
    var numberOfDosor: Double
    var pricePerDosa: Double
    var portionsPerDosa: Int
    var savingsGoal: Int
    var startDate: Date
    var streak: Streak
    
    init(name: String, numberOfDosor: Double, pricePerDosa: Double, portionsPerDosa: Int, savingsGoal: Int, startDate: Date,  streak: Streak = Streak()) {
        self.name = name
        self.numberOfDosor = numberOfDosor
        self.pricePerDosa = pricePerDosa
        self.startDate = startDate
        self.portionsPerDosa = portionsPerDosa
        self.savingsGoal = savingsGoal
        self.streak = streak
   
    }
}
