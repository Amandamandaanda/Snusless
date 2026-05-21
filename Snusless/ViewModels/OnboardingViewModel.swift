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
    var savingGoal: Int = 0
    var portionsPerDosa: Int = 20
    var startDate: Date = Date()
    var errorMessage: String = ""
    
    var onboardingState: OnboardingState = .onboardingName
    
    var isNameValid: Bool {
        name.trimmingCharacters(in: .whitespaces).count >= 2
    }
    
    var isDosorValid: Bool {
        numberOfDosor > 0
    }
    
    var isValidPrice: Bool {
        pricePerDosa > 0.0
    }
    
    var isValidGoal: Bool {
        savingGoal > 0
    }
    
    var canProceed: Bool {
        return isValidPrice && isValidGoal
    }
    
    
    // Added prints for testing and save user is working!
    func saveUser(context: ModelContext) {
        guard validation() else {
            return
        }
        let user = User(name: name.trimmingCharacters(in: .whitespaces), numberOfDosor: numberOfDosor, pricePerDosa: pricePerDosa, portionsPerDosa: portionsPerDosa, savingsGoal: savingGoal, startDate: startDate, streak: Streak())
        
        context.insert(user)
        
        do {
            try context.save()
            print("User Saved")
            print("name: \(user.name), dosor: \(user.numberOfDosor), price: \(user.pricePerDosa), portions: \(user.portionsPerDosa), savingsGoal: \(user.savingsGoal), startDate: \(user.startDate), streak: \(user.streak.currentStreak)")
            errorMessage = ""
            onboardingState = .onboardingDone
        } catch {
            print("User could not be saved")
            errorMessage = "Användaren kunde inte sparas: \(error.localizedDescription)"
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
