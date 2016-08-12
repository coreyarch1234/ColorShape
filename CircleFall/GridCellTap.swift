//
//  GridCellTap.swift
//  CircleFall
//
//  Created by Corey Harrilal on 8/8/16.
//  Copyright © 2016 coreyarchharrilal. All rights reserved.
//


import Foundation
import SpriteKit
//Should define the properties of the circles that will be created.

func numberToColor(tappedNumber: Int) -> SKColor {
    
    let colors = [SKColor.whiteColor(), blueColor, pinkColor, yellowColor]
    
    return colors[tappedNumber]
}

class GridCellTap: SKSpriteNode {
    
  
    var tappedNumber: Int = 0 {
        didSet {
            recordTapped()
        }
    }
    
    func recordTapped(){
        isTapped = true
        self.color = numberToColor(tappedNumber)
        
        
        switch tappedNumber{
        case 1:
             // Blue
            self.color = blueColor
        case 2:
           // Pink
            self.color = pinkColor
        case 3:
            
            self.color = yellowColor
        default:
            self.color = SKColor.whiteColor()
        }
        
    }
    
   
    var isTapped: Bool = false
    var xCoord: Int
    var yCoord: Int
    
    init() {
        let texture = SKTexture(imageNamed: "gridCellWhite.png")
        xCoord = 0
        yCoord = 0
        super.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        self.zPosition = 4
        self.colorBlendFactor = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}