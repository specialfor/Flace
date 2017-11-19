//
//  UIView+Gradient.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 10/11/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

enum GradientDirection {
    case fromTop
    case fromBottom
}

fileprivate typealias Points = (start: CGPoint, end: CGPoint)

extension UIView {
    
    func drawLinearGradient(in context: CGContext?, colors: [CGColor], direction: GradientDirection) {
        let points = self.points(direction)
        let locations: [CGFloat] = [0.0, 1.0]
        
        context?.drawLinearGradient(with: colors, locations: locations, from: points.start, to: points.end)
    }
    
    fileprivate func points(_ direction: GradientDirection) -> Points {
        var startPoint: CGPoint
        var endPoint: CGPoint
        
        switch direction {
        case .fromTop:
            startPoint = CGPoint(x: bounds.midX, y: 0)
            endPoint = CGPoint(x: bounds.midX, y: bounds.height)
        case .fromBottom:
            startPoint = CGPoint(x: bounds.midX, y: bounds.height)
            endPoint = CGPoint(x: bounds.midX, y: 0)
        }
        
        return (startPoint, endPoint)
    }
    
}
