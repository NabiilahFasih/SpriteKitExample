//
//  GameScene.swift
//  SpriteKitExample
//
//  Created by Nabiilah Fasih on 2/23/17.
//  Copyright © 2017 PointClickCare. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory
{
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Monster   : UInt32 = 0b1     // 1*2^0 = 1             : 01
    static let Projectile: UInt32 = 0b10    // 0*2^0 + 1*2^1 = 2     : 10
}

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
        
        //1- Configure physics world
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
    }
    
    private func addMovingMonster()
    {
        let monster = SKSpriteNode(imageNamed: "monster")
        
        let yPosition = Util.random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        let xPosition = size.width + monster.size.width/2
        monster.position = CGPoint(x: xPosition, y: yPosition)
        addChild(monster)
        
        //2- Add physics body to monster
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size)
        monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        monster.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        let duration = TimeInterval(Util.random(min: 2.0, max: 4.0))
        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: yPosition), duration: duration)
        let actionMoveDone = SKAction.removeFromParent()
        
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first else
        {
            return
        }
        let touchLocation = touch.location(in: self)
        
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        addChild(projectile)
        
        //3- Add physics body to projectile
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        
        let offset = touchLocation - projectile.position
        if (offset.x < 0) { return }
        
        let direction = offset.normalized()
        let shootAmount = direction * 1000
        
        let destination = shootAmount + projectile.position
        
        let actionMove = SKAction.move(to: destination, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
}

extension GameScene : SKPhysicsContactDelegate
{
    func didBegin(_ contact: SKPhysicsContact)
    {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Monster != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
            if let monster = firstBody.node as? SKSpriteNode, let
                projectile = secondBody.node as? SKSpriteNode {
                projectileDidCollideWithMonster(projectile: projectile, monster: monster)
            }
        }
    }
    
    func projectileDidCollideWithMonster(projectile: SKSpriteNode, monster: SKSpriteNode)
    {
        print("Hit")
        projectile.removeFromParent()
        monster.removeFromParent()
    }
}
