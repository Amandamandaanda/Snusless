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
        
        if user.streak.checkedinDays.firstIndex(where: {
            Calendar.current.isDateInToday($0)
        }) != nil {

        } else {
            user.streak.checkedinDays.append(today)
            updateLongestStreak(for: user)
            user.totalSaved += user.dailySavings
        }
        
        do {
            try context.save()
        } catch {
            errorMessage = "Kunde inte spara"
        }
    }
    
    func resetStreak(user: User, context: ModelContext) {
        errorMessage = nil
        
        // Save longest streak before resetting
        updateLongestStreak(for: user)
        
        if user.calculatePortions() > user.totalSnusNotTaken {
            user.totalSnusNotTaken = user.calculatePortions()
        }
        // Reset the streak
        user.streak.resetStreak()
        
        // Add snus taken to user
        user.snusTakenCount += 1
        
        
        do {
            try context.save()
        } catch {
            errorMessage = "Kunde inte spara"
        }
    }
    
    func checkAndResetStreakIfBroken(user: User, context: ModelContext) {
        // Check if the streak is broken (missed more than 1 day)
        if user.streak.isStreakBroken {
            // Save the longest streak before resetting
            updateLongestStreak(for: user)
            
            // Reset the streak
            user.streak.resetStreak()
            
            do {
                try context.save()
            } catch {
                errorMessage = "Kunde inte spara"
            }
        }
    }
    
    private func updateLongestStreak(for user: User) {
        let currentStreak = user.streak.currentStreak
        if currentStreak > user.longestStreak {
            user.longestStreak = currentStreak
        }
    }
}
