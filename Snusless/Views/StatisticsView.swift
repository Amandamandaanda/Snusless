//
//  StatisticsView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-06-03.
//

import SwiftUI
import SwiftData


struct StatisticsView: View {
  

    @State private var viewModel = HomeViewModel()
    @Query private var users: [User]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let user = users.first {
                
                StatisticsCard(title: String(localized: "Du har sparat:"), description: "\(Int(user.totalSaved)) kr")
                
                StatisticsCard(title: String(localized: "Nuvarande streak"), description: "\(user.streak.currentStreak) dagar")
                
                StatisticsCard(title: String(localized: "Max streak: "), description: "\(user.longestStreak) dagar")
                
                StatisticsCard(
                    title: String(localized: "Du har klarat dig utan:"),
                    description: String(format: String(localized:  "%.0f portioner snus"), user.calculatePortions())
                )
                
                
                
                StatisticsCard(title: String(localized: "Maximum snus du skippat:"), description: user.totalSnusNotTaken == 0 ? String(format: "%.0f portioner snus", user.calculatePortions()) : String(format: String(localized: "%.0f portioner snus"), user.totalSnusNotTaken))
                
                               
                if user.snusTakenCount > 0 {
                    StatisticsCard(title: String(localized: "Du har tagit:"), description: "\(user.snusTakenCount) \(String(localized: "portioner snus"))"
                                 , foregroundColorTitle: .errorRed)
                }
                
                Spacer()
            }
            
        }
        .frame(maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .title) {
                Text("Statistik")
                    .font(.custom("Roboto-Bold", size: 20))
                    .foregroundColor(.black)
            }

        }
    }
}

#Preview {
    NavigationStack {
        StatisticsView()
    }
}
