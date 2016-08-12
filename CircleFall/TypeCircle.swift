//
//  TypeCircle.swift
//  CircleFall
//
//  Created by Corey Harrilal on 7/12/16.
//  Copyright © 2016 coreyarchharrilal. All rights reserved.
//

import Foundation
import SpriteKit
//Should define the properties of the circles that will be created.

class TypeCircle: SKSpriteNode {
    
    var circleNumber: Int {
        didSet {
            
           circleNumberLabel.text = String(circleNumber)

            
        }
    }
    
    
    var circleNumberLabel: SKLabelNode!
    var xCoord: Int
    var yCoord: Int
    
    init(color: SKColor, circleNumber: Int) {
        self.circleNumber = circleNumber
        let texture = SKTexture(imageNamed: "CircleSprite.png")
        xCoord = 0
        yCoord = 0
        super.init(texture: texture, color: color, size: CGSizeMake(120, 120))
        //Create and define the label node with aesthetics
        circleNumberLabel = SKLabelNode(text: String(circleNumber))
        circleNumberLabel.fontColor = SKColor.whiteColor()
        circleNumberLabel.position = CGPointMake(self.position.x - 2, self.position.y - 12.0)
        circleNumberLabel.zPosition = 3.00
        circleNumberLabel.fontName = "ArialBlack-Bold"
        circleNumberLabel.xScale = 0.8
        self.addChild(circleNumberLabel)
        self.zPosition = 3
        self.colorBlendFactor = 1
    }
    
    func circleEven() -> Bool {
        if self.circleNumber % 2 == 0{
            return true
        }
        return false
    }
           
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
