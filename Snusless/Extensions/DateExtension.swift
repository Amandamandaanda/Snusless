//
//  DateExtension.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-26.
//

import Foundation

extension Date {

    func formattedMedium(locale: Locale = .current) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = locale
        return formatter.string(from: self)
    }
    
    func formattedLong(locale: Locale = .current) -> String {
        return self.formatted(.dateTime.day().month(.wide).year().locale(locale))
    }
}
