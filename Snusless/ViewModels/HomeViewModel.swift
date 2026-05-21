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
    
    func checkToday(user: User, context: ModelContext) {
        
        errorMessage = nil
        
        let today = Calendar.current.startOfDay(for: Date())
        
        if let index = user.streak.checkedinDays.firstIndex(where: {
            Calendar.current.isDateInToday($0) 
        }) {
            user.streak.checkedinDays.remove(at: index)
        } else {
            user.streak.checkedinDays.append(today)
        }
        
        do {
            try context.save()
        } catch {
            errorMessage = "Kunde inte spara"
        }
    }
}
