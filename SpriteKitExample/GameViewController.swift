//
//  GameViewController.swift
//  SpriteKitExample
//
//  Created by Nabiilah Fasih on 2/23/17.
//  Copyright © 2017 PointClickCare. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        
        let skView = view as! SKView
        skView.presentScene(scene)
    }
    
}
