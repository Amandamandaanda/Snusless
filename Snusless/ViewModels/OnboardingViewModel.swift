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
    var numberOfDosor: Double? = nil
    var pricePerDosa: Double? = nil
    var savingGoal: Int? = nil
    var portionsPerDosa: Int = 20
    var startDate: Date = Date()
    var errorMessage: String = ""

    var onboardingState: OnboardingState = .onboardingName

    var isNameValid: Bool {
        name.trimmingCharacters(in: .whitespaces).count >= 2
    }

    var isDosorValid: Bool {
        (numberOfDosor ?? 0) > 0
    }

    var isValidPrice: Bool {
        (pricePerDosa ?? 0) > 0.0
    }

    var isValidGoal: Bool {
        (savingGoal ?? 0) > 0
    }

    var canProceed: Bool {
        return isValidPrice && isValidGoal
    }

    func isActive(_ state: OnboardingState) -> Bool {
        onboardingState == state
    }

    // Added prints for testing and save user is working
    func saveUser(context: ModelContext) {
        guard validation() else {
            return
        }

        let user = User(
            name: name.trimmingCharacters(in: .whitespaces),
            numberOfDosor: numberOfDosor ?? 0,
            pricePerDosa: pricePerDosa ?? 0,
            portionsPerDosa: portionsPerDosa,
            savingsGoal: savingGoal ?? 0,
            startDate: startDate,
            streak: Streak(),
            snusTakenCount: 0,
            totalSnusNotTaken: 0
        )

        user.streak = Streak.startingStreak(for: user)

        let numberOfDays = user.streak.checkedinDays.count
        user.totalSaved = Double(numberOfDays) * user.dailySavings

        context.insert(user)

        do {
            try context.save()
            print("User Saved")
            print(
                "name: \(user.name), dosor: \(user.numberOfDosor), price: \(user.pricePerDosa), portions: \(user.portionsPerDosa), savingsGoal: \(user.savingsGoal), startDate: \(user.startDate), totalSaved: \(user.totalSaved)"
            )
            errorMessage = ""
            onboardingState = .onboardingDone
        } catch {
            print("User could not be saved")
            errorMessage =
                "Användaren kunde inte sparas: \(error.localizedDescription)"
        }

    }

    func validation() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Vänligen fyll i ditt namn"
            return false
        }

        guard (numberOfDosor ?? 0) > 0 else {
            errorMessage = "Antalet dosor får inte vara noll"
            return false
        }

        guard (pricePerDosa ?? 0) > 0.0 else {
            errorMessage =
                "Vänligen fyll i priset för din snusdosa. Priset får inte vara noll"
            return false
        }

        guard portionsPerDosa > 0 else {
            errorMessage =
                "Vänligen fyll i hur många portioner din dosa innehåller."
            return false
        }
        return true
    }

}
