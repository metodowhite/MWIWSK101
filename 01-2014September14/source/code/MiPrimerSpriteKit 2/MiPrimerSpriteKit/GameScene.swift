//
//  GameScene.swift
//  MiPrimerSpriteKit
//
//  Created by metodowhite on 14/09/14.
//  Copyright (c) 2014 metodowhite. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let paddle = SKSpriteNode(imageNamed: "paddle")
    let ballCategory: UInt32 = 0x1          // 00000000000000000000000000000001
    let brickCategory: UInt32 = 0x1 << 1    // 00000000000000000000000000000010
    let paddleCategory: UInt32 = 0x1 << 2   // 00000000000000000000000000000100
    
    override func didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.backgroundColor = SKColor.grayColor()
        
        // self.size = CGSize(width: 320, height: 568)
        self.physicsWorld.gravity = CGVector(0, 0)
        self.physicsWorld.contactDelegate = self
        // println(self.frame)
        
        addBall()
        addPlayer()
        addBrick()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            var restrictedYLocation = CGPoint(x: location.x, y: 100.0)
            
            if restrictedYLocation.x < CGRectGetWidth(self.paddle.frame)/2 {
                restrictedYLocation = CGPoint(x: CGRectGetWidth(self.paddle.frame)/2, y: 100.0)
            }
            
            if restrictedYLocation.x > self.size.width - (CGRectGetWidth(self.paddle.frame)/2) {
                restrictedYLocation = CGPoint(x: self.size.width - (CGRectGetWidth(self.paddle.frame)/2), y: 100.0)
            }
            
            paddle.position = restrictedYLocation
        }
    }
    
    func addBall() {
        let ball = SKSpriteNode(imageNamed:"ball")
        ball.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        ball.xScale = 0.5
        ball.yScale = 0.5
        
        //Physics
        ball.physicsBody = SKPhysicsBody(circleOfRadius: CGRectGetWidth(ball.frame)/2)
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.restitution = 1.0
        
        
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = brickCategory | paddleCategory // 00000000000000000000000000000110
        // ball.physicsBody?.collisionBitMask = edgeCategory | brickCategory
        
        self.addChild(ball)
        
        //importante aplicar impulsos despues de "addChild"
        let myVector = CGVector(20, 20)
        ball.physicsBody?.applyImpulse(myVector)
    }
    
    func addPlayer() {
        paddle.position = CGPoint(x:CGRectGetMidX(self.frame), y:100.0);
        paddle.xScale = 0.5
        paddle.yScale = 0.5
        //Physics
        paddle.physicsBody = SKPhysicsBody(rectangleOfSize: paddle.size)
        // make it static
        paddle.physicsBody?.dynamic = false
        
        self.addChild(paddle)
    }
    
    func addBrick() {
        for brickIndex in 1...3 {
            let brick = SKSpriteNode(imageNamed: "brick")
            brick.physicsBody = SKPhysicsBody(rectangleOfSize: brick.size)
            brick.physicsBody?.dynamic = false
            
            let xPos = (size.width/3 * CGFloat(brickIndex + 1.0)) - 100
            let yPos = size.height - 50
            
            brick.position = CGPoint(x: xPos, y: yPos)
            
            self.addChild(brick)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        println(contact.contactPoint)
    }
}
















