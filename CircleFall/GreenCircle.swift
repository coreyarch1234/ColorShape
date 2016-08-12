//
//  GreenCircle.swift
//  CircleFall
//
//  Created by Corey Harrilal on 7/24/16.
//  Copyright © 2016 coreyarchharrilal. All rights reserved.
//

import Foundation
import SpriteKit
//Should define the properties of the circles that will be created.

class GreenCircle: SKSpriteNode {
    
    var xCoord: Int
    var yCoord: Int
    var isPigThere: Bool = false
    
    func pigThere(){
        isPigThere = true
    }
    
    
    
    
    init() {
        
        let texture = SKTexture(imageNamed: "piggy-bank.png")
        xCoord = 0
        yCoord = 0
        super.init(texture: texture, color: SKColor.greenColor(), size: CGSize(width: 60, height: 60))
        self.zPosition = 6
        self.colorBlendFactor = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
