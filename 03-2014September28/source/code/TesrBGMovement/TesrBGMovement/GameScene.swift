//
//  GameScene.swift
//  TesrBGMovement
//
//  Created by metodowhite on 28/09/14.
//  Copyright (c) 2014 metodowhite. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let bg = SKSpriteNode(imageNamed: "background")
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        myLabel.text = "Hello, World!";
        myLabel.fontColor = UIColor.blackColor()
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        bg.position = CGPoint(x: 0, y: 300)
        self.addChild(bg)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let mitadPantalla = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
            let moveAction = SKAction.moveBy(CGVector(-10, 0), duration: 1)
            let moveAction2 = SKAction.moveBy(CGVector(-20, 0), duration: 1)
            
            if touch.locationInView(self.view).x > mitadPantalla.x {
                myLabel.runAction(moveAction2)
                bg.runAction(moveAction)
            } else if touch.locationInView(self.view).x < mitadPantalla.x {
                myLabel.runAction(moveAction2.reversedAction())
                bg.runAction(moveAction.reversedAction())
            }

        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
