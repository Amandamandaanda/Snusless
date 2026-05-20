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
    var startDate: Date
    var streak: Streak
    
    init(name: String, numberOfDosor: Int, pricePerDosa: Double, portionsPerDosa: Int, startDate: Date,  streak: Streak = Streak()) {
        self.name = name
        self.numberOfDosor = numberOfDosor
        self.pricePerDosa = pricePerDosa
        self.startDate = startDate
        self.portionsPerDosa = portionsPerDosa
        self.streak = streak
   
    }
}
