//
//  GameScene.swift
//  HitTest1
//
//  Created by metodowhite on 28/09/14.
//  Copyright (c) 2014 metodowhite. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        
        
        let blueBox = self.childNodeWithName("blueBox")
        blueBox?.userInteractionEnabled = true
//        blueBox?.physicsBody?.categoryBitMask = X
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            
            let location = touch.locationInNode(self)
            
            let contactoInvisible = SKShapeNode(circleOfRadius: 10)
//            contactoInvisible.physicsBody?.categoryBitMask = X
//
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
//        println(blueBox?.position)
    }
}











