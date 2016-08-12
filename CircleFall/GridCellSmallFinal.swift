//
//  GridCellSmallFinal.swift
//  CircleFall
//
//  Created by Corey Harrilal on 7/27/16.
//  Copyright © 2016 coreyarchharrilal. All rights reserved.
//

import Foundation
import SpriteKit
//Should define the properties of the circles that will be created.

class GridCellSmallFinal: SKSpriteNode {
    //Amount that must be incremented
    var gridNumber: Int {
        didSet {
            updateLabel()
        }
    }
    //Out of this much
    var gridNumberTotal: Int {
        didSet {
            updateLabel()
        }
    }
    func updateLabel() {
        
        gridNumberLabel.text = "\(gridNumber) / \(gridNumberTotal)"
    }
    func clear() {
        isBlocked = false
        //hideLabel()
        texture = SKTexture(imageNamed: "GridCellNewShadow.png")
    }
    //Will be called to either make a cell blocked. True is blocked. 
    func becomeBlocked() {
        isBlocked = true
        texture = SKTexture(imageNamed: "blockNew.png")
        hideLabel()
    }
    func becomeLabelShown(){
        isBlocked = false
        isGridLabel = true
        gridNumberLabel.hidden = false
    }
    func hideLabel() {
        isGridLabel = false
        gridNumberLabel.hidden = true
    }
    var isBlocked = false
    var isGridLabel = false
    var gridNumberLabel: SKLabelNode!
    var xCoord: Int
    var yCoord: Int
    
    init(gridNumber: Int, gridNumberTotal: Int) {
        self.gridNumber = gridNumber
        self.gridNumberTotal = gridNumberTotal
        let texture = SKTexture(imageNamed: "GridCellNewShadow.png")
        xCoord = 0
        yCoord = 0
        super.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        gridNumberLabel = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        gridNumberLabel.fontColor = SKColor.whiteColor()
        gridNumberLabel.position = CGPointMake(self.position.x - 2, self.position.y - 13)
        gridNumberLabel.zPosition = 6.00
        gridNumberLabel.fontName = "AvenirNext-Heavy"
        
        gridNumberLabel.xScale = 0.8
        gridNumberLabel.fontSize = 30
        gridNumberLabel.hidden = true
        updateLabel()
        self.addChild(gridNumberLabel)
        self.zPosition = 5
        self.colorBlendFactor = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}