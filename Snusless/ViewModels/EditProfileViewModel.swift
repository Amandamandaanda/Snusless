//
//  EditProfileViewModel.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-28.
//

import Foundation
import SwiftData

@Observable
class EditProfileViewModel {
    
    var editName: String = ""
    var originalName: String = ""
    var editStartDate: Date = Date()
    var editDosor: Int = 0
    var editPrice: Double = 0.0
    var editPortioner: Int = 0
    var editSavingsGoal: Int = 0
    
    func updateUser(context: ModelContext, updatedName: String, updatedDate: Date, updatedDosor: Int, updatedPortions: Int, updatedPrice: Double, updatedSavingsGoal: Int) {
            do {
                let descriptor = FetchDescriptor<User>()
                if let existingUser = try context.fetch(descriptor).first {
                    // Update the SwiftData model
                    existingUser.name = updatedName.trimmingCharacters(in: .whitespaces)
                    existingUser.startDate = updatedDate
                    existingUser.numberOfDosor = updatedDosor
                    existingUser.portionsPerDosa = updatedPortions
                    existingUser.pricePerDosa = updatedPrice
                    existingUser.savingsGoal = updatedSavingsGoal

                    existingUser.streak = Streak.startingStreak(for: existingUser)
                    
                    try context.save()
                    print("Användardata har uppdaterats i SwiftData och ViewModel:\n\(updatedName)\n\(updatedDate.formattedMedium())\n\(updatedDosor)\n\(updatedPortions)\n\(updatedPrice)\n\(updatedSavingsGoal)")
                }
            } catch {
                print("Misslyckades med att uppdatera användaren: \(error.localizedDescription)")
            }
        }
}
