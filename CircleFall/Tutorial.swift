//
//  Tutorial.swift
//  CircleFall
//
//  Created by Corey Harrilal on 8/5/16.
//  Copyright © 2016 coreyarchharrilal. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit



class Tutorial: SKScene {
    
    var images: [SKNode!] = []
    
    override func didMoveToView(view: SKView) {
        images.append(childNodeWithName("TutorialOne"))
        images.append(childNodeWithName("TutorialTwo"))
        images.append(childNodeWithName("TutorialThree"))
        images.append(childNodeWithName("TutorialFour"))
        
        for image in images {
            image.hidden = true
        }
        
        images[0].hidden = false
    }
    
    var index = 0
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        images[index].hidden = true
        
        index += 1
        
        if index == images.count {
            // go to next scene
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameSceneFinal(fileNamed:"GameScenePtTwo")!
            
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart GameScene */
            skView.presentScene(scene)
            //scene.pigButton.hidden = true
        }
        else {
            images[index].hidden = false
        }
        
    }
    
}
