//
//  MainMenu.swift
//  CircleFall
//
//  Created by Corey Harrilal on 8/9/16.
//  Copyright © 2016 coreyarchharrilal. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: SKScene{

    var easierButton: MSButtonNode!
    var mediumMoreButton: MSButtonNode!
    var granderMasterButton: MSButtonNode!
    
    var colorShapeLabel: SKSpriteNode!
    
    func animateButtons(){
        
        let downColor = SKAction.moveToY(1020.0, duration: 1)
        let upColor = SKAction.moveToY(1056, duration: 1)
        
        let downEasier = SKAction.moveToY(770.0, duration: 1)
        let upEasier = SKAction.moveToY(789, duration: 1)
        
        let downMedium = SKAction.moveToY(520.0, duration: 1)
        let upMedium = SKAction.moveToY(539, duration: 1)
        
        let downGrand = SKAction.moveToY(257.0, duration: 1)
        let upGrand = SKAction.moveToY(276, duration: 1)
        
        colorShapeLabel.runAction(SKAction.repeatActionForever(SKAction.sequence([downColor, upColor])))
        easierButton.runAction(SKAction.repeatActionForever(SKAction.sequence([downEasier, upEasier])))
        mediumMoreButton.runAction(SKAction.repeatActionForever(SKAction.sequence([downMedium, upMedium])))
        granderMasterButton.runAction(SKAction.repeatActionForever(SKAction.sequence([downGrand, upGrand])))
        
    }
    
override func didMoveToView(view: SKView) {

    colorShapeLabel = self.childNodeWithName("colorShapeLabel") as! SKSpriteNode
    
    easierButton = self.childNodeWithName("easierButton") as! MSButtonNode
    mediumMoreButton = self.childNodeWithName("mediumMoreButton") as! MSButtonNode
    granderMasterButton = self.childNodeWithName("granderMasterButton") as! MSButtonNode

    
    let minusOne = SKLabelNode()
    minusOne.text = ""
    minusOne.fontSize = 100
    minusOne.fontName = "Futura-CondensedMedium"
    minusOne.fontColor = SKColor.blackColor()
    minusOne.position = CGPoint(x: -100.0, y: -100.0)


    let plusOne = SKLabelNode()
    plusOne.text = "+1"
    plusOne.fontSize = 100
    plusOne.fontName = "Futura-CondensedMedium"
    plusOne.fontColor = SKColor.greenColor()
    plusOne.position = CGPoint(x: -100.0, y: -100.0)



    self.animateButtons()

        easierButton.selectedHandler = {
        /* Grab reference to the SpriteKit view */
        let skView = self.view as SKView!
        
        /* Load Game scene */
        let scene = GameSceneTap(fileNamed:"ShapeTap") as GameSceneTap!
        
        /* Ensure correct aspect mode */
        scene.scaleMode = .AspectFill
            scene.mode = 0

        //let tempScore = NSUserDefaults.standardUserDefaults().stringForKey("highScore0")
        /* Restart GameScene */
            scene.saveHighScore()
        skView.presentScene(scene)

        scene.startTime = 15
        scene.actualTime = 15
//        scene.actualTimeAdded = 3
//        scene.scoreDecremented = 1
//        
    }
    
    mediumMoreButton.selectedHandler = {
        /* Grab reference to the SpriteKit view */
        let skView = self.view as SKView!
        
        /* Load Game scene */
        let scene = GameSceneTap(fileNamed:"ShapeTap") as GameSceneTap!
        
        
        
        /* Ensure correct aspect mode */
        scene.scaleMode = .AspectFill
        scene.mode = 1
        
        /* Restart GameScene */


        skView.presentScene(scene)

        scene.startTime = 8
        scene.actualTime = 8

        
    }
    
    
    granderMasterButton.selectedHandler = {
        /* Grab reference to the SpriteKit view */
        let skView = self.view as SKView!
        
        /* Load Game scene */
        let scene = GameSceneTap(fileNamed:"ShapeTap") as GameSceneTap!
        
        
        
        /* Ensure correct aspect mode */
        scene.scaleMode = .AspectFill
        scene.mode = 2

        /* Restart GameScene */


        skView.presentScene(scene)

        scene.startTime = 5
        scene.actualTime = 5

        
    }
    
    }
}

