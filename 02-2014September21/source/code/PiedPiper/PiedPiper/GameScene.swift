//
//  GameScene.swift
//  PiedPiper
//
//  Created by metodowhite on 21/09/14.
//  Copyright (c) 2014 metodowhite. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        //        myLabel.text = "Hello, World!";
        //        myLabel.fontSize = 65;
        //        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        //
        //        self.addChild(myLabel)
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            createYoshi(location)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func createYoshi(location: CGPoint) {
        
        // 1
        // let yoshiSprite = SKSpriteNode(imageNamed: "yoshi1")
        // yoshiSprite.position = location
        // self.addChild(yoshiSprite)
        
        // 2
        var yoshiTextures = [SKTexture]()
        
        for textureIndex in 1...8 {
            let yoshiTexture = SKTexture(imageNamed: "yoshi\(textureIndex)")
            yoshiTextures.append(yoshiTexture)
        }
        
        let yoshiSprite = SKSpriteNode(texture: yoshiTextures[0])
        yoshiSprite.position = location
        
        
        let runRightAction = SKAction.animateWithTextures(yoshiTextures, timePerFrame: 0.1)
        let runForever = SKAction.repeatActionForever(runRightAction)
        
//        SKAction.playSoundFileNamed(<#soundFile: String#>, waitForCompletion: <#Bool#>)
        
        yoshiSprite.runAction(runForever)
        yoshiSprite.physicsBody = SKPhysicsBody(rectangleOfSize: yoshiSprite.size)
        // yoshiSprite.physicsBody?.allowsRotation = false
        
        self.addChild(yoshiSprite)
    }
}





















