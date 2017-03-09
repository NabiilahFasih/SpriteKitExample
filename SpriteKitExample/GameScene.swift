//
//  GameScene.swift
//  SpriteKitExample
//
//  Created by Nabiilah Fasih on 2/23/17.
//  Copyright © 2017 PointClickCare. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    let player = SKSpriteNode(imageNamed: "player")
    
    override func didMove(to view: SKView)
    {
        backgroundColor = SKColor.white
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        addChild(player)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMovingMonster),
                SKAction.wait(forDuration: 1.0)
            ])
        ))
    }
    
    private func addMovingMonster()
    {
        let monster = SKSpriteNode(imageNamed: "monster")
        
        //Create monster sprite
        let yPosition = Util.random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        let xPosition = size.width + monster.size.width/2
        monster.position = CGPoint(x: xPosition, y: yPosition)
        addChild(monster)
        
        //Create actions
        let duration = TimeInterval(Util.random(min: 2.0, max: 4.0))
        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: yPosition), duration: duration)
        let actionMoveDone = SKAction.removeFromParent()
        
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    /*
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        //Create projectile sprite
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        addChild(projectile)
        
        //Use of Vector Math to find direction
        let direction = touchLocation - projectile.position
        
        //Shooting backwards - ignore it
        if (direction.x < 0) { return }
        
        //Normalize to unit vector + Multiple with value enough to shoot it off screen
        let unitDirection = direction.normalized()
        let shootAmount = unitDirection * 1000
        
        //Final destination
        let finalDestination = projectile.position + shootAmount
        
        let actionMove = SKAction.move(to: finalDestination, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    */
}
