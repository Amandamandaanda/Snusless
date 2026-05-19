//
//  HomeViewModel.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-18.
//

import SwiftData
import Foundation

@Observable
class HomeViewModel{
    
    var errorMessage: String?
    
    func checkToday(streak: Streak, context: ModelContext) {
        
        errorMessage = nil
        
        let today = Calendar.current.startOfDay(for: Date())
        
        if let index = streak.completedDays.firstIndex(where: {
            Calendar.current.isDateInToday($0)
        }) {
            streak.completedDays.remove(at: index)
        } else {
            streak.completedDays.append(today)
        }
        
        do {
            try context.save()
        } catch {
            errorMessage = "Kunde inte spara"
        }
    }
}
