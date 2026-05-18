//
//  OnboardingViewModel.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-18.
//

import Foundation
import SwiftData

@Observable
class OnboardingViewModel {
    var name: String = ""
    var numberOfDosor: Int = 0
    var pricePerDosa: Double = 0.0
    var portionsPerDosa: Int = 0
    var startDate: Date = Date()
    var errorMessage: String = ""
    
    var userState: UserState = .notCreated
    
    
    func saveUser(context: ModelContext) {
        guard validation() else {
            errorMessage = "Vänligen fyll i alla fält"
            return
        }
        let user = User(name: name.trimmingCharacters(in: .whitespaces), completedDays: [], numberOfDosor: numberOfDosor, pricePerDosa: pricePerDosa, portionsPerDosa: portionsPerDosa, startDate: startDate)
        
        context.insert(user)
        
        do {
            try context.save()
            errorMessage = ""
            userState = .userCreated
        } catch {
            errorMessage = "Användaren kunde inte sparas: \(error.localizedDescription)"
            userState = .notCreated
        }
        
    }
    
    func validation() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Vänligen fyll i ditt namn"
            return false
        }
        
        guard numberOfDosor > 0 else {
            errorMessage = "Antalet dosor får inte vara noll"
            return false
        }
        
        guard pricePerDosa > 0.0  else {
            errorMessage = "Vänligen fyll i priset för din snusdosa. Priset får inte vara noll"
            return false
        }
        guard portionsPerDosa > 0 else {
            errorMessage = "Vänligen fyll i hur många portioner din dosa innehåller."
            return false
        }
        return true
    }
}
