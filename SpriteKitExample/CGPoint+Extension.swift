//
//  CGPoint+Extension.swift
//  SpriteKitExample
//
//  Created by Nabiilah Fasih on 3/7/17.
//  Copyright © 2017 PointClickCare. All rights reserved.
//

import UIKit

extension CGPoint
{
    //Overloading operator methods
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    static func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x / scalar, y: point.y / scalar)
    }
    
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {  //Convert to unit vector(size 1)
        return self / length()
    }
}
