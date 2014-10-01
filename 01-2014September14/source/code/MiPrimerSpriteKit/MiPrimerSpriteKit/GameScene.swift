//
//  GameScene.swift
//  MiPrimerSpriteKit
//
//  Created by metodowhite on 14/09/14.
//  Copyright (c) 2014 metodowhite. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        // self.size = CGSize(width: 320, height: 568)
        // self.physicsWorld.gravity = CGVector(5, 10)
        println(self.frame)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            // let sprite = SKSpriteNode(imageNamed:"Spaceship")
            //
            // sprite.xScale = 0.5
            // sprite.yScale = 0.5
            // sprite.position = location
            //
            // let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            //
            // sprite.runAction(SKAction.repeatActionForever(action))
            //
            // self.addChild(sprite)
            
            let ball = SKSpriteNode(imageNamed:"ball")
            //            ball.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
            ball.position = location
            ball.xScale = 0.5
            ball.yScale = 0.5
            
            //Physics
            ball.physicsBody = SKPhysicsBody(circleOfRadius: CGRectGetWidth(ball.frame)/2)
            
            self.addChild(ball)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
