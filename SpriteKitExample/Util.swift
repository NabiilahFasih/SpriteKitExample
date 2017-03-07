//
//  Utilities.swift
//  SpriteKitExample
//
//  Created by Nabiilah Fasih on 3/7/17.
//  Copyright © 2017 PointClickCare. All rights reserved.
//

import UIKit

class Util
{
    static func random() -> CGFloat
    {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat
    {
        return random() * (max - min) + min
    }
}
