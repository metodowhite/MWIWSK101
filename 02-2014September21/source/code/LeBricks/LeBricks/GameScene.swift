//
//  GameScene.swift
//  LeBricks
//
//  Created by metodowhite on 21/09/14.
//  Copyright (c) 2014 metodowhite. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKShapeNode(rectOfSize: CGSize(width: 100, height: 20))
    
    let ballCategory: UInt32 = 0x1
    let brickCategory: UInt32 = 0x1 << 1
    let playerCategory: UInt32 = 0x1 << 2
    let edgeCategory: UInt32 = 0x1 << 3
    let bottomCategory: UInt32 = 0x1 << 4
    
    
    override func didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        self.addBall()
        self.addPlayer()
        self.addBricks(3, size: CGSize(width: 70, height: 20), position: CGPoint(x: 70, y: 500))
        self.addBottomEdge()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            player.position.x = location.x
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        println("Boing!")
        
        var notTheBall: SKPhysicsBody?;
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            notTheBall = contact.bodyB
        } else {
            notTheBall = contact.bodyA
        }
        
        if notTheBall?.categoryBitMask == brickCategory {
            notTheBall?.node?.removeFromParent()
        }
        
        if notTheBall?.categoryBitMask == bottomCategory {
            println("Cuack!")
            
            let gameOverScene = GameOverScene()
            self.view?.presentScene(gameOverScene, transition: SKTransition.doorsOpenHorizontalWithDuration(1))
        }

    }
    
    func addBall() {
        let ball = SKShapeNode(circleOfRadius: 10)
        ball.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        ball.fillColor = UIColor.whiteColor()
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.restitution = 1.0
        
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = brickCategory | playerCategory | bottomCategory
        // ball.physicsBody?.collisionBitMask = edgeCategory | brickCategory
        
        self.addChild(ball)
        
        /* Se agregan fuerzas SIEMPRE despues de addChild */
        ball.physicsBody?.applyImpulse(CGVectorMake(5, 5))
    }
    
    func addPlayer() {
        /* Error tipico de reposicionamiento al crear nodos */
        // let spritePlayer = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 100, height: 20))
        // spritePlayer.position = CGPoint(x: CGRectGetMidX(self.frame) - spritePlayer.frame.size.width/2, y: 50)
        
        player.position = CGPoint(x: CGRectGetMidX(self.frame), y: 100)
        player.fillColor = UIColor.whiteColor()
        
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.frame.size)
        player.physicsBody?.dynamic = false
        
        self.addChild(player)
    }
    
    func addBricks(cant: Int, size: CGSize, position: CGPoint) {
        for brickIndex in 0...cant {
            let brick = SKShapeNode(rectOfSize: size)
            brick.position.y = position.y
            brick.position.x = ((self.size.width / CGFloat(cant)) * CGFloat(brickIndex + 1.0) - size.width ) + 20
            brick.fillColor = UIColor.whiteColor()
            
            brick.physicsBody = SKPhysicsBody(rectangleOfSize: brick.frame.size)
            brick.physicsBody?.dynamic = false
            brick.physicsBody?.categoryBitMask = brickCategory
            
            self.addChild(brick)
        }
    }
    
    
    func addBottomEdge() {
        let bottomEdge: SKNode = SKNode()
        bottomEdge.physicsBody = SKPhysicsBody(edgeFromPoint: CGPoint(x: 0, y: 1), toPoint: CGPoint(x: self.size.width, y: 1))
        bottomEdge.physicsBody?.categoryBitMask = bottomCategory
        self.addChild(bottomEdge)
    }
}



















