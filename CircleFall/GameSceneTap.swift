//
//  GameSceneTap.swift
//  CircleFall
//
//  Created by Corey Harrilal on 8/8/16.
//  Copyright © 2016 coreyarchharrilal. All rights reserved.
//


import Foundation
import SpriteKit

enum GameSceneStateTap {
    case Active, GameOver
}

let gridRowsTap = 6
let gridColumnsTap = 6
let gridCellWidthTap: CGFloat = 100.0
let gridCellHeightTap: CGFloat = 100.0

let blueColor = SKColorWithRGB(29, g: 119, b: 239)
let pinkColor = SKColorWithRGB(251, g: 43, b: 105)
let yellowColor = SKColorWithRGB(255, g: 205, b: 2)

var highScoreArray: [Int] = [NSUserDefaults.standardUserDefaults().integerForKey("highScore0") ?? 0,NSUserDefaults.standardUserDefaults().integerForKey("highScore1") ?? 0, NSUserDefaults.standardUserDefaults().integerForKey("highScore2") ?? 0]




class GameSceneTap: SKScene {
    

var lastTapped: (x: Int, y: Int)!
var playAgain: MSButtonNode!
var backButton: MSButtonNode!
var mainMenuButton: MSButtonNode!
var checkInGridDecision: Bool = true
var highScoreLabel: SKLabelNode!
var mode = 0

    var goalInstructionNumberLabel: SKLabelNode!
    var goalInstructionColorLabel: SKSpriteNode!
    var timeLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    
    
var gridCellTap: [[GridCellTap]] = []
    
    var instructionColor: Int = 0 {
        didSet{
            
            updateLabels()
        }
    }
    var instructionNumber: Int = 0 {
        didSet{
            updateLabels()
        }
    }
    
    
    var startTime: Double = 0
    
    var actualTime: Double = 0 {
        didSet{
            updateLabels()
        }
    }
//    var actualTimeAdded: Double = 0{
//        didSet{
//            updateLabels()
//        }
//    }
//    var scoreDecremented: Int = 0 {
//        didSet{
//            updateLabels()
//        }
//    }
    var scoreTap: Int = 0{
        didSet{
            updateLabels()
        }

    }
    var gameOverLabel: SKLabelNode!
    
    var sceneTap: GameSceneStateTap = .Active

    func updateLabels() {
        goalInstructionNumberLabel.text = String(instructionNumber)
        goalInstructionColorLabel.color = numberToColor(instructionColor)
        scoreLabel.text = String(scoreTap)
        
        timeLabel.text = String(Int(actualTime + 0.5))
        
    }
    func saveHighScore(){
        let prefs = NSUserDefaults.standardUserDefaults()
        
        prefs.setInteger(highScoreArray[0], forKey: "highScore0")
        prefs.setInteger(highScoreArray[1], forKey: "highScore1")
        prefs.setInteger(highScoreArray[2], forKey: "highScore2")
        
    }




    
    func createGridCellTap(gridRowsTap: Int, gridColumnsTap: Int) {
        for x in 0...gridColumnsTap - 1{
            var column = [GridCellTap]()
            for y in 0...gridRowsTap - 1{
                let randomNum = Int(arc4random_uniform(UInt32(3))) + 1
                let gridCell = GridCellTap()
                gridCell.position = screenPosition(x, y: y)
                gridCell.tappedNumber = randomNum
                addChild(gridCell)
                column.append(gridCell)
            }
            gridCellTap.append(column)
        }
    }


    override func didMoveToView(view: SKView) {
      
        
        highScoreLabel = self.childNodeWithName("highScore") as! SKLabelNode
        highScoreLabel.text = String(highScoreArray[mode])
        highScoreLabel.zPosition = 5
        
        playAgain = self.childNodeWithName("playAgain") as! MSButtonNode
        backButton = self.childNodeWithName("backButton") as! MSButtonNode
        
        goalInstructionNumberLabel = childNodeWithName("goalInstructionNumberLabel") as! SKLabelNode
        goalInstructionColorLabel = childNodeWithName("goalInstructionColorLabel") as! SKSpriteNode
        timeLabel = childNodeWithName("timeLabel") as! SKLabelNode
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        gameOverLabel = childNodeWithName("gameOverLabel") as! SKLabelNode
        
        createGridCellTap(gridRowsTap, gridColumnsTap: gridColumnsTap)
        let instructions = generateRandomInstruction()
        instructionColor = instructions.instructionColor
        instructionNumber = instructions.instructionNumber
        
        playAgain.selectedHandler = {
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            //self.highScoreLabel.zPosition = 0
            
            /* Load Game scene */
            let sceneTap = GameSceneTap(fileNamed:"ShapeTap") as GameSceneTap!
            
            /* Ensure correct aspect mode */
            sceneTap.scaleMode = .AspectFill
            
            sceneTap.mode = self.mode
            
            /* Restart GameScene */


            skView.presentScene(sceneTap)

            sceneTap.startTime = self.startTime
            sceneTap.actualTime = self.startTime
//            sceneTap.actualTimeAdded = self.actualTimeAdded
//            sceneTap.scoreDecremented = self.scoreDecremented
            
            
            }
        
        backButton.selectedHandler = {
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let sceneTap = MainMenu(fileNamed:"MainMenu") as MainMenu!
            
            /* Ensure correct aspect mode */
            sceneTap.scaleMode = .AspectFill
            self.saveHighScore()
            /* Restart GameScene */
            skView.presentScene(sceneTap)
            self.saveHighScore()
            
        }
    }
    
    
    func screenPosition(x: Int, y: Int) -> CGPoint {
        let cellSizeWidth = gridCellWidthTap
        let cellSizeHeight = gridCellHeightTap
        let screenX: Double = 70.0 + Double(x) * Double(cellSizeWidth)
        let screenY: Double = (291.36 * 0.8) + Double(y) * Double(cellSizeHeight)
        return CGPoint(x: screenX, y: screenY)
    }
    
    //Calculates the grid coordinate from a screen position
    func gridPosition(screenX: CGFloat, screenY: CGFloat) -> (x: Int, y: Int){
        let cellSizeWidth = gridCellWidthTap
        let cellSizeHeight = gridCellHeightTap
        let gridX: Int  = Int(((screenX - 70.0) / cellSizeWidth) + 0.5)
        let gridY: Int = Int(((screenY - (291.36 * 0.8)) / cellSizeHeight) + 0.5)
        return (x: gridX, y: gridY)
    }
    
    //Checks to see if any point is out of the grid's bounds
    func checkBounds(x: Int, y: Int) -> Bool{
        if x >= 0 && x < gridColumnsTap && y >= 0 && y < gridRowsTap {
            return true
        }
        return false
    }

    //Check whole grid for connected boxes equal to the number- instructionCounter. 6 Columns and 6 Rows to check
    func checkGridForPoints(instructionNumber: Int, instructionColor: Int) -> (Bool, [GridCellTap]) {
        
        if instructionNumber == 0 {
            return (true, [])
        }
        
        
        for column in 0..<gridColumnsTap{
            var gridArray: [GridCellTap] = [] // 1 all the way up to instruction number
            for row in 0..<gridRowsTap{
                
                if gridCellTap[column][row].tappedNumber == instructionColor {
                    gridArray.append(gridCellTap[column][row])
                    
                }
                else{
                    if gridArray.count == instructionNumber {
                        //To tell if it is a column
                        
                        return (true, gridArray)
                    }
                    gridArray.removeAll()
                }
            }
            if gridArray.count == instructionNumber {
                return (true, gridArray)
            }
        }
        for row in 0..<gridRowsTap{
            var gridArray: [GridCellTap] = [] // 1 all the way up to instruction number
            for column in 0..<gridColumnsTap{
                
                if gridCellTap[column][row].tappedNumber == instructionColor {
                    gridArray.append(gridCellTap[column][row])
                }
                else{
                    if gridArray.count == instructionNumber {
                        return (true, gridArray)
                    }
                    gridArray.removeAll()
                }
            }
            if gridArray.count == instructionNumber {
                return (true, gridArray)
            }
        }
        
        return (false, [])
    }
    
    func generateRandomInstruction() -> (instructionNumber: Int, instructionColor: Int){
        // Instruction Number, Numbers from 1 to 6
        var Number: Int = 0
        var Color: Int = 0
        
        while checkGridForPoints(Number, instructionColor: Color).0 {
        
            Number = Int(arc4random_uniform(UInt32(6))) + 1
            
            Color = Int(arc4random_uniform(UInt32(3))) + 1
        }
        
        return (instructionNumber: Number, instructionColor: Color)
        
    }
    
    func endGame(){
        sceneTap = .GameOver
        
        //Animate GameOver Animation
        let gameOverAnimation = SKAction.scaleBy(1.5, duration: 1)
        let coverGameLabel = SKAction.hide()
        gameOverLabel.zPosition = 5
        gameOverLabel.runAction(SKAction.sequence([gameOverAnimation, coverGameLabel]))
        
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            
            if sceneTap == .Active{
                
                

                /* Grab scene position of touch */
                let location = touch.locationInNode(self)
                let locationInGrid = gridPosition(location.x, screenY: location.y)
                
                
                if checkBounds(locationInGrid.x, y: locationInGrid.y) {

                    gridCellTap[locationInGrid.x][locationInGrid.y].removeAllActions()
                    gridCellTap[locationInGrid.x][locationInGrid.y].runAction(SKAction.sequence([
                        SKAction.scaleTo(0.75, duration: 0.1),
                        SKAction.scaleTo(1.0, duration: 0.1),
                    ]))
                    
                    gridCellTap[locationInGrid.x][locationInGrid.y].recordTapped()
                    //Tap Once and Increment Tap Counter
                    if gridCellTap[locationInGrid.x][locationInGrid.y].tappedNumber < 3{
                    gridCellTap[locationInGrid.x][locationInGrid.y].tappedNumber += 1
                    }
                    else{
                        gridCellTap[locationInGrid.x][locationInGrid.y].tappedNumber = 1
                        
                    }
                    //Animate the decrease in score because you tapped once
                    if lastTapped == nil || lastTapped.x != locationInGrid.x || lastTapped.y != locationInGrid.y {
                        scoreTap -= 1
                    
                        //if checkInGridDecision == true{
                        let minusOne = SKLabelNode()
                        minusOne.text = "- 1"
                        minusOne.fontSize = 100
                        minusOne.fontName = "Futura-CondensedMedium"
                        minusOne.fontColor = SKColor.blackColor()
                        minusOne.position = screenPosition(locationInGrid.x, y: locationInGrid.y)
                        minusOne.zPosition = 6
                        minusOne.runAction(SKAction.sequence([
                        SKAction.moveBy(CGVector(dx: 0, dy: 80), duration: 2),
                        SKAction.removeFromParent()
                        ]))
                        minusOne.runAction(SKAction.sequence([
                        SKAction.waitForDuration(1),
                        SKAction.fadeOutWithDuration(1)
                        ]))
                        self.addChild(minusOne)
                    //}
                        //checkInGridDecision = false
                       
                }
                    lastTapped = locationInGrid
                    
                    
                }
            
            if checkGridForPoints(instructionNumber, instructionColor: instructionColor).0 == true{
                timeLabel.removeAllActions()
                //Animate the increase in points and add it
                scoreTap += instructionNumber
                scoreLabel.runAction(SKAction.sequence([
                    SKAction.scaleTo(1.2, duration: 0.1),
                    SKAction.scaleTo(1, duration: 0.1),
                    ]))
                actualTime += 1
                timeLabel.runAction(SKAction.sequence([
                    SKAction.scaleTo(1.2, duration: 0.1),
                    SKAction.scaleTo(1, duration: 0.1),
                    ]))

                
                
                //Randomize The column or row that the player got points from
                let gridArray = checkGridForPoints(instructionNumber, instructionColor: instructionColor).1

                var duration = 0.1
                for cell in gridArray {
                    let effectCell = GridCellTap()
                    effectCell.position = cell.position
                    effectCell.zPosition = 5
                    effectCell.tappedNumber = cell.tappedNumber
                    
                    
                    effectCell.runAction(SKAction.sequence([
                        SKAction.scaleTo(1.5, duration: duration),
                        SKAction.removeFromParent()
                        ]))
                    effectCell.runAction(SKAction.fadeOutWithDuration(duration))
                    self.addChild(effectCell)
                    
                    duration += 0.1
                    
                    let plusOne = SKLabelNode()
                    plusOne.text = "+1"
                    plusOne.fontSize = 100
                    plusOne.fontName = "Futura-CondensedMedium"
                    plusOne.fontColor = SKColor.greenColor()
                    plusOne.position = cell.position
                    plusOne.zPosition = 6
                    plusOne.runAction(SKAction.sequence([
                        SKAction.moveBy(CGVector(dx: 0, dy: 80), duration: 2),
                        SKAction.removeFromParent()
                        ]))
                    plusOne.runAction(SKAction.sequence([
                        SKAction.waitForDuration(1),
                        SKAction.fadeOutWithDuration(1)
                    ]))
                    self.addChild(plusOne)
                    
                    checkInGridDecision = true
                    
                    
                }
                    
                for cell in gridArray{
                    let randomNum = Int(arc4random_uniform(UInt32(3))) + 1
                    cell.tappedNumber = randomNum
                }

                let instructions = generateRandomInstruction()
                instructionColor = instructions.instructionColor
                instructionNumber = instructions.instructionNumber
                goalInstructionColorLabel.runAction(SKAction.sequence([
                    SKAction.scaleTo(1.5, duration: 0.1),
                    SKAction.scaleTo(1, duration: 0.1),
                    ]))

            }
            
            }
        }
        
        }

    override func update(currentTime: CFTimeInterval) {
        
        if sceneTap == .Active {
            if mode == 0{
            if actualTime >= 0 {
                
                actualTime -= (1/60)
                if actualTime <= 6{
                    timeLabel.fontColor = SKColor.redColor()
                }
                
            }
            else {
                actualTime = 0
                endGame()
               
                if scoreTap > highScoreArray[mode]{
                    highScoreArray[mode] = scoreTap
                    saveHighScore()
                    highScoreLabel.text = String(highScoreArray[mode])
                    print(highScoreArray[mode])
                    highScoreLabel.color = SKColor.redColor()
                    highScoreLabel.runAction(SKAction.sequence([
                        SKAction.scaleTo(1.2, duration: 0.1),
                        SKAction.scaleTo(1, duration: 0.1),
                        ]))
                    
                }
                playAgain.zPosition = 6
            }
                
                
            }
            if mode == 1{
            if actualTime >= 0 {
                
                actualTime -= (1/30)
                if actualTime <= 6{
                    timeLabel.fontColor = SKColor.redColor()
                }
                
            }
            else {
                actualTime = 0
                endGame()
                
                if scoreTap > highScoreArray[mode]{
                    highScoreArray[mode] = scoreTap
                    saveHighScore()
                    highScoreLabel.text = String(highScoreArray[mode])
                    print(highScoreArray[mode])
                    highScoreLabel.color = SKColor.redColor()
                    highScoreLabel.runAction(SKAction.sequence([
                        SKAction.scaleTo(1.2, duration: 0.1),
                        SKAction.scaleTo(1, duration: 0.1),
                        ]))
                    
                }
                playAgain.zPosition = 6
            }
            }
            
            if mode == 2{
            if actualTime >= 0 {
                
                actualTime -= (1/20)
                if actualTime <= 6{
                    timeLabel.fontColor = SKColor.redColor()
                }
                
            }
            else {
                actualTime = 0
                endGame()
                
                if scoreTap > highScoreArray[mode]{
                    highScoreArray[mode] = scoreTap
                    saveHighScore()
                    highScoreLabel.text = String(highScoreArray[mode])
                    print(highScoreArray[mode])
                    highScoreLabel.color = SKColor.redColor()
                    highScoreLabel.runAction(SKAction.sequence([
                        SKAction.scaleTo(1.2, duration: 0.1),
                        SKAction.scaleTo(1, duration: 0.1),
                        ]))
                    
                }
                playAgain.zPosition = 6
            }
            }
            
        }
    }
}
