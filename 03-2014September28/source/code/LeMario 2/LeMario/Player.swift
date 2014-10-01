//
//  Player.swift
//  LeMario
//
//  Created by metodowhite on 28/09/14.
//  Copyright (c) 2014 metodowhite. All rights reserved.
//

import SpriteKit

class Player: SKShapeNode {
    let moveAction = SKAction.moveBy(CGVector(dx: 1, dy: 0), duration: 1.0)

    func spawnPlayerAtPosition(position : CGPoint) {
        self.fillColor = UIColor.redColor()
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.frame.size.width / 2)
        
        self.position = position
    }
    
    
    func spawnPlayerAtPositionOfNode(node: SKNode) {
        self.fillColor = UIColor.redColor()
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.frame.size.width / 2)
        
        let startPointPosition = node.position
        self.position = position
    }
    
    func runToTheRight() {
//        self.runAction(moveAction)
        self.physicsBody?.applyImpulse(CGVectorMake(5, 0))
    }
    
    func runToTheLeft() {
        self.physicsBody?.applyImpulse(CGVectorMake(-5, 0))
//        self.runAction(moveAction.reversedAction())

    }
    
    func jump() {
        self.physicsBody?.applyImpulse(CGVectorMake(0, 10))
    }

}
