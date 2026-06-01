//
//  NavigationExtensions.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-28.
//

import SwiftUI

extension OnboardingNavigation {
    func slideTransition(isGoingForward: Bool) -> AnyTransition {
        .asymmetric(insertion: .move(edge: isGoingForward ? .trailing : .leading).combined(with: .opacity), removal: .move(edge: isGoingForward ? .leading : .trailing).combined(with: .opacity))
    }
}
