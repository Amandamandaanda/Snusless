//
//  SettingsViewModel.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-25.
//

import SwiftData
import Foundation

@Observable
class SettingsViewModel {
    
    var errorMessage: String?
    
    func deleteData(users: [User], context: ModelContext) {
        
        errorMessage = nil
        
        for user in users {
            context.delete(user)
        }
        do {
            try context.save()
        } catch {
            errorMessage = "Failed to delete:\(error.localizedDescription)"
        }
    }
}
