//
//  Shapes.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-22.
//

import SwiftUI

struct OverViewCardFigma: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.addRoundedRect(in: CGRect(x: 0.01249*width, y: 0, width: 0.9863*width, height: 0.95694*height), cornerSize: CGSize(width: 0.05479*width, height: 0.09569*height))
        
        path.move(to: CGPoint(x: 0.00701*width, y: 0.27721*height))
        path.addCurve(to: CGPoint(x: 0.33578*width, y: 0.29753*height), control1: CGPoint(x: 0.08992*width, y: 0.19095*height), control2: CGPoint(x: 0.25674*width, y: 0.19225*height))
        
        path.move(to: CGPoint(x: 0.39085*width, y: 0.3696*height))
        path.addCurve(to: CGPoint(x: 0.4303*width, y: 0.82297*height), control1: CGPoint(x: 0.46141*width, y: 0.48469*height), control2: CGPoint(x: 0.47089*width, y: 0.66022*height))
        
        path.move(to: CGPoint(x: 0.41487*width, y: 0.88615*height))
        path.addCurve(to: CGPoint(x: 0.3755*width, y: 0.95633*height), control1: CGPoint(x: 0.40657*width, y: 0.91896*height), control2: CGPoint(x: 0.3898*width, y: 0.94185*height))
        path.addCurve(to: CGPoint(x: 0.35085*width, y: 0.97608*height), control1: CGPoint(x: 0.36208*width, y: 0.96991*height), control2: CGPoint(x: 0.35085*width, y: 0.97608*height))
        
        return path
    }
}
