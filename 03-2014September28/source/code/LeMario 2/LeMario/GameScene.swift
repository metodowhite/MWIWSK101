//
//  GameScene.swift
//  LeMario
//
//  Created by metodowhite on 28/09/14.
//  Copyright (c) 2014 metodowhite. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let player = Player(circleOfRadius: 10)
    let light = SKLightNode()
    let fireEmitter = SKEmitterNode(fileNamed: "MyParticle.sks")


    
    let enemiesArray = [AnyObject]()
    
    let playerCategory: UInt32 = 0x1
    let pisoCategory: UInt32 = 0x1 << 1
    let enemyCategory: UInt32 = 0x1 << 2
    let worldCategory: UInt32 = 0x1 << 3
    
    let lightCategory: UInt32 = 0x1 << 10
    
    
    
    override func didMoveToView(view: SKView) {
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter.setDefaults()
        blurFilter.setValue(5.0, forKey: "inputRadius")
        
        let blurEffectNode = SKEffectNode()
        blurEffectNode.filter = blurFilter
        blurEffectNode.shouldEnableEffects = true
        self.addChild(blurEffectNode)
        
        self.filter = blurFilter
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.categoryBitMask = worldCategory
        
        let enemy = self.childNodeWithName("enemy")
        enemy?.physicsBody?.categoryBitMask = enemyCategory
        
        
        //        let startPoint = self.childNodeWithName("startPoint")
        player.spawnPlayerAtPosition(CGPoint(x: 100, y: 100))
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = worldCategory | enemyCategory
        blurEffectNode.addChild(player)
        
        let piso1 = self.childNodeWithName("piso1")
        let piso1Position = piso1?.position
        createNewSetOfLedgeNodes(self, startingPoint: piso1Position!, leftSide: CGPoint(x: 10, y: 200), blockCount: 7)
        createNewSetOfLedgeNodes(self, startingPoint: piso1Position!, leftSide: CGPoint(x: 10, y: 400), blockCount: 7)
        
        createLight()
        loadEnemies()
        addParticles()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let mitadPantalla = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
            
            if touch.locationInView(self.view).x > mitadPantalla.x {
                player.runToTheRight()
            } else if touch.locationInView(self.view).x < mitadPantalla.x {
                player.runToTheLeft()
            }
            
            if touch.locationInView(self.view).y < mitadPantalla.y {
                player.jump()
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        light.position = player.position
        fireEmitter.position = player.position
    }
    
    func createNewSetOfLedgeNodes(scene: SKScene, startingPoint: CGPoint, leftSide: CGPoint, blockCount: Int) {
        
        var ubicacion = leftSide
        var blockArray = [AnyObject]()
        let brickWidth = 50.0
        let brickHeight = 5.0
        
        for index in 1...blockCount {
            //            let brick = SKShapeNode(rectOfSize: CGSize(width: brickWidth, height: brickHeight))
            let brick = SKSpriteNode(imageNamed: "Rectangle1")
            //            brick.fillColor = UIColor.greenColor()
            brick.physicsBody = SKPhysicsBody(rectangleOfSize: brick.frame.size)
            brick.physicsBody?.categoryBitMask = pisoCategory
            brick.xScale = 0.5
            brick.position = ubicacion
            //            brick.physicsBody?.affectedByGravity = false
            
            brick.lightingBitMask = lightCategory
            brick.shadowCastBitMask = lightCategory
            
            if index == 1 {
                brick.physicsBody?.dynamic = false
            } else if index == blockCount {
                brick.physicsBody?.dynamic = false
            }
            
            ubicacion.x += CGFloat(brickWidth) + 10
            
            blockArray.append(brick)
            
            scene.addChild(brick)
        }
        
        for index in 0...(blockArray.count-2) {
            let nodeA: SKSpriteNode = blockArray[index] as SKSpriteNode
            let nodeB: SKSpriteNode = blockArray[index+1] as SKSpriteNode
            
            //            let theJoint = SKPhysicsJoint.jointWithBodyA(
            //                nodeA.physicsBody,
            //                bodyB: nodeB.physicsBody,
            //                anchor: CGPoint(x: nodeB.position.x, y: nodeB.position.y)
            //            )
            
            let theJoint = SKPhysicsJointSpring.jointWithBodyA(
                nodeA.physicsBody,
                bodyB: nodeB.physicsBody,
                anchorA: CGPoint(x: nodeA.position.x + 10, y: nodeA.position.y),
                anchorB: CGPoint(x: nodeB.position.x - 10, y: nodeB.position.y)
            )
            
            theJoint.damping = 1
            theJoint.frequency = 5
            
            scene.physicsWorld.addJoint(theJoint)
        }
    }
    
    
    func loadEnemies() {
        let path = NSBundle.mainBundle().pathForResource("Enemies", ofType: "plist")
        let plistDictionary = NSDictionary(contentsOfFile: path!)
        //        let levels: Dictionary = plistDictionary["Level"] as Dictionary
        //        let level1  = levels["One"]
        
        println(plistDictionary)
        
        //        for enemy in plistDictionary {
        //
        //            let leEnemyNode = SKShapeNode(rectOfSize: CGSize(width: 50, height: 50))
        //            let leEnemyDictionary = enemy as Dictionary
        //
        //            if leEnemyDictionary["Type"] == 1 {
        //                leEnemy.fillColor = UIColor.greenColor()
        //            }
        //
        //            if leEnemyDictionary["Type"] == 2 {
        //                leEnemy.fillColor = UIColor.blueColor()
        //            }
        //
        //            leEnemy.physicsBody = SKPhysicsBody(rectangleOfSize: brick.frame.size)
        //            leEnemy.physicsBody?.categoryBitMask = pisoCategory
        //            leEnemy.position = CGPoint(x: leEnemyDictionary["posX"], y: leEnemyDictionary["posY"])
        //
        //            self.addChild(leEnemy)
        //        }
    }
    
    func createLight() {
        light.enabled = true
        light.lightColor = UIColor.yellowColor()
        light.categoryBitMask = 0xFFFFFFFF
        light.alpha = 0.3
        self.addChild(light)
    }
    
    
    func addParticles() {
        fireEmitter.targetNode = self
        self.addChild(fireEmitter)
        
//        let fire = NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks")
//        let burstEmitter:SKEmitterNode = fire as SKEmitterNode
//        fireEmitter.numParticlesToEmit = 400
//        
//        
//        fireEmitter.position = CGPoint(x: 100, y: 100)
//        self.addChild(fireEmitter)
    }
}














