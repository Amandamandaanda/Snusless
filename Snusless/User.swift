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
    var completedDays: [Date] = []
    var numberOfDosor: Int
    var pricePerDosa: Double
    var portionsPerDosa: Int
    var startDate: Date
    
    init(name: String, completedDays: [Date], numberOfDosor: Int, pricePerDosa: Double, portionsPerDosa: Int, startDate: Date) {
        self.name = name
        self.completedDays = completedDays
        self.numberOfDosor = numberOfDosor
        self.pricePerDosa = pricePerDosa
        self.startDate = startDate
        self.portionsPerDosa = portionsPerDosa
    }
}
