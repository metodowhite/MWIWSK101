//
//  GameOverScene.swift
//  LeBricks
//
//  Created by metodowhite on 21/09/14.
//  Copyright (c) 2014 metodowhite. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    override func didMoveToView(view: SKView) {
//        let funkyLabel = SKLabelNode(fontNamed: "Chalkduster")
//        funkyLabel.fontColor = UIColor.whiteColor()
//        funkyLabel.fontSize = 66
//        funkyLabel.text = "Le Game Over"
//        funkyLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
//        self.addChild(funkyLabel)
        
        self.backgroundColor = UIColor.blueColor()
        let myLabel = SKLabelNode()
        myLabel.text = "Le Game Over";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)

    }
}
