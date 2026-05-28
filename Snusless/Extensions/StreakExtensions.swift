//
//  StreakExtensions.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-18.
//
import Foundation

extension Streak {
    
    var isCompletedToday: Bool {
        checkedinDays.contains{Calendar.current.isDateInToday($0)
        }
    }
    
    var currentStreak: Int {
        
        let calendar = Calendar.current
        
        let uniqueDays = Set(
            checkedinDays.map{ calendar.startOfDay(for: $0)}
        )
        
        let sortedDays = uniqueDays.sorted(by: >)
        
        guard let latest = sortedDays.first else {
            return 0
        }
        
        let today = calendar.startOfDay(for: Date())
        
        let diff = calendar.dateComponents([.day], from: latest, to: today).day ?? 0
        
        if diff > 1 {
            return 0
        }
        
        var streak = 1
        var expected = calendar.date(byAdding: .day, value: -1, to: latest)!
        
        for day in sortedDays.dropFirst(){
            if day == expected {
                streak += 1
                expected = calendar.date(byAdding: .day, value: -1, to: expected)!
            } else {
                break
            }
        }
        return streak
    }
    
    static func startingStreak(for user: User) -> Streak {
        let streak = user.streak
        
        streak.checkedinDays.removeAll()
        
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: user.startDate)

        let today = calendar.startOfDay(for: Date())

        var currentDate = start

        while currentDate <= today {

            streak.checkedinDays.append(currentDate)

            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return streak
    }
}


