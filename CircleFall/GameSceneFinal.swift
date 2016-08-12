//
//  GameSceneFinal.swift
//  CircleFall
//
//  Created by Corey Harrilal on 7/24/16.
//  Copyright © 2016 coreyarchharrilal. All rights reserved.
//

import Foundation
import SpriteKit


enum BlockDirection: Int {
    case left = 0, right, up, down
}

enum GameSceneState {
    case Active, GameOver
}

let gridRows = 6
let gridColumns = 6
let gridCellWidth: CGFloat = 100.0
let gridCellHeight: CGFloat = 100.0

class GameSceneFinal: SKScene {
    var nextMoveCreateBlock: Bool = false
    //Player Score is the score for the Actual Red Score
    var coinAmount: Int = 50 {
        didSet {
            actualRedScore.text = String(coinAmount)
        }
    }
    
    var scoreAmount: Int = 0{
        didSet{
            actualScore.text = String(scoreAmount)
        }
    }
    var teleportCost: Int = 20 {
        didSet {
            actualTeleportCost.text = String(teleportCost)
        }
    }
    var bombCost: Int = 20 {
        didSet {
            actualBombCost.text = String(bombCost)
        }
    }
    //Try again Button
    var tryAgain: MSButtonNode!
    var betAll: MSButtonNode!
    var whiteFlag: MSButtonNode!
    //var pigButton: MSButtonNode!
    var gameState: GameSceneState = .Active
    var actualScore: SKLabelNode!
    
    
    
    
    var destroyers: Int = 0
    //var highRedScore: SKLabelNode!
    var actualRedScore: SKLabelNode!
    var actualTeleportCost: SKLabelNode!
    var actualBombCost: SKLabelNode!
    var heroPig: GreenCircle = CircleGeneratorFinal.createGreenCircle()
    var gridCellSmallArray: [[GridCellSmallFinal]] = []
    var bombIcon: MSButtonNode!
    var teleportIcon: MSButtonNode!
    var explosion: SKSpriteNode!
    //To determine whether or not to teleport when a node is touched
    var teleportChoice: Bool = false

    func createGridCellArray(gridRows: Int, gridColumns: Int) {
        for x in 0...gridColumns - 1{
            var column = [GridCellSmallFinal]()
            for y in 0...gridRows - 1{
                let gridCell = GridCellSmallFinal(gridNumber: 1, gridNumberTotal: 10)
                gridCell.position = screenPosition(x, y: y)
                addChild(gridCell)
                column.append(gridCell)
            }
            gridCellSmallArray.append(column)
        }
    }

    //To create random blocks and it comes after the generation of the grid cell array
    func randomBlockGenerator(initialX: Int, initialY: Int){
        var gridArray = gridCellSmallArray
        
        var directionToHead = BlockDirection.right
        
        var x = initialX
        var y = initialY
        
        print("initial: \(initialX) \(initialY)")
        
        while true {
            if checkBounds(x, y: y) == false {
                break
            }
            print("block: \(x) \(y)")
            gridArray[x][y].becomeBlocked()
            if CGFloat.random() < 0.2 {
                directionToHead = BlockDirection(rawValue: (random() % 4))!// new direction
            }
            
            switch directionToHead {
            case .right:
                x += 1
            case .left:
                x -= 1
            case .up:
                y += 1
            case .down:
                y -= 1
            }
        }
        
    }
    func respondToSwipeGesture(sender: UIGestureRecognizer) {
        if teleportChoice == false{
        if let swipeGesture = sender as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Right:
                print("DONE")
                //Get the location of the swipe
                let loc = view!.convertPoint(sender.locationInView(view), toScene: self)
                let node = self.nodeAtPoint(loc)
                if true //Force Unwrap
                {
                    
                    //Make sure that the circle is not in the last column and that there is nothing to   the right of it
                    if heroPig.xCoord < gridColumns - 1 && gridCellSmallArray[heroPig.xCoord + 1][heroPig.yCoord].isBlocked == false {
                        
                        if nextMoveCreateBlock {
                            gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].becomeBlocked()
                            nextMoveCreateBlock = false
                        }
                        
                        heroPig.xCoord += 1
                        heroPig.position = screenPosition(heroPig.xCoord, y: heroPig.yCoord)
                        scoreAmount += 1
                        
                        //Check if pig landed on point tile and spawn a new one with a size point
                        
                        if gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].isGridLabel{
                            //Increment player score
                            coinAmount += gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].gridNumber

                            //Hide absorbed tile until it is updated
                            gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].hideLabel()
                            //Create new Tile with size point
                            incrementAllTiles()
                            createNewPointTile("Small")
                            nextMoveCreateBlock = true
                            
                        }
                        else {
                             //coinAmount -= 1
                             incrementAllTiles()
                        }
                        
                       
                    }
                    print(heroPig.position)
                    
                }
                
            case UISwipeGestureRecognizerDirection.Down:
                print("DONE")
                let loc = view!.convertPoint(sender.locationInView(view), toScene: self)
                let node = self.nodeAtPoint(loc)
                if true
                {
                    if heroPig.yCoord > 0 && gridCellSmallArray[heroPig.xCoord][heroPig.yCoord - 1].isBlocked == false {
                        if nextMoveCreateBlock {
                            gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].becomeBlocked()
                            nextMoveCreateBlock = false
                        }
                        heroPig.yCoord -= 1
                        heroPig.position = screenPosition(heroPig.xCoord, y: heroPig.yCoord)
                        scoreAmount += 1
                        
                        if gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].isGridLabel{
                            coinAmount += gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].gridNumber
                            gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].hideLabel()
                            incrementAllTiles()
                            createNewPointTile("Small")
                            nextMoveCreateBlock = true
                        }
                        else{
                            //coinAmount -= 1
                            
                            incrementAllTiles()
                        }
                        
                    }
                    print(heroPig.position)
              }

            case UISwipeGestureRecognizerDirection.Left:
                print("DONE")
                let loc = view!.convertPoint(sender.locationInView(view), toScene: self)
                let node = self.nodeAtPoint(loc)
                if true
                {
                    if heroPig.xCoord > 0  && gridCellSmallArray[heroPig.xCoord - 1][heroPig.yCoord].isBlocked == false  {
                        if nextMoveCreateBlock {
                            gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].becomeBlocked()
                            nextMoveCreateBlock = false
                        }
                        
                        heroPig.xCoord -= 1
                        heroPig.position = screenPosition(heroPig.xCoord, y: heroPig.yCoord)
                        scoreAmount += 1

                        
                        if gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].isGridLabel{
                            coinAmount += gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].gridNumber
                            gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].hideLabel()
                            incrementAllTiles()
                            createNewPointTile("Small")
                            nextMoveCreateBlock = true
                
                        }
                        else{
                            //coinAmount -= 1
                            incrementAllTiles()
                        }
                    }
                    print(heroPig.position)
                }
            case UISwipeGestureRecognizerDirection.Up:
                print("DONE")
                let loc = view!.convertPoint(sender.locationInView(view), toScene: self)
                let node = self.nodeAtPoint(loc)
                if true
                {
                    if heroPig.yCoord < gridRows - 1 && gridCellSmallArray[heroPig.xCoord][heroPig.yCoord + 1].isBlocked == false {
                        if nextMoveCreateBlock {
                            gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].becomeBlocked()
                            nextMoveCreateBlock = false
                        }
                        
                        heroPig.yCoord += 1
                        heroPig.position = screenPosition(heroPig.xCoord, y: heroPig.yCoord)
                        scoreAmount += 1
                        
                        if gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].isGridLabel{
                            coinAmount += gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].gridNumber
                            gridCellSmallArray[heroPig.xCoord][heroPig.yCoord].hideLabel()
                            incrementAllTiles()
                            createNewPointTile("Small")
                            nextMoveCreateBlock = true
                        }
                        else{
                            //coinAmount -= 1
                            incrementAllTiles()
                        }
                    }
                    print(heroPig.xCoord)
                    print(heroPig.yCoord)
                }
            default:
                break
            }
        }
        lostTheGame()

    }
        
    }
    
    
    //Gives the initial position of the block
    func callingBlocks(){
        let x = Int(arc4random_uniform(UInt32(gridColumns)))
        let y = Int(arc4random_uniform(UInt32(gridRows)))
        let random = CGFloat.random()
        if random < 0.5{
            randomBlockGenerator(0, initialY: y)
        }
        else if random < 0.8 {
            randomBlockGenerator(gridColumns - 1, initialY: y)
        }
        else{
            randomBlockGenerator(x, initialY: gridRows - 1)
        }
    }
    
    override func didMoveToView(view: SKView) {
        
        
        
        //PigButton Tutorial
        //pigButton = self.childNodeWithName("PigButton") as! MSButtonNode
        
        //Try again
        tryAgain = self.childNodeWithName("tryAgain") as! MSButtonNode
        
        tryAgain.selectedHandler = {
            
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameSceneFinal(fileNamed:"GameScenePtTwo") as GameSceneFinal!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart GameScene */
            skView.presentScene(scene)
        }
        
        tryAgain.state = MSButtonNodeState.MSButtonNodeStateHidden
        
        
        //BetAll
        
        betAll = self.childNodeWithName("BetAll") as! MSButtonNode
        
        betAll.state = MSButtonNodeState.MSButtonNodeStateActive
        
        //White Flag
        whiteFlag = self.childNodeWithName("WhiteFlag") as! MSButtonNode
        
        whiteFlag.state = MSButtonNodeState.MSButtonNodeStateHidden
        

        actualScore = childNodeWithName("ActualScore") as! SKLabelNode
        actualScore.text = String(scoreAmount)
        actualRedScore = childNodeWithName("ActualRedScore") as! SKLabelNode
        actualTeleportCost = childNodeWithName("ActualTeleportCost") as! SKLabelNode
        actualBombCost = childNodeWithName("ActualBombCost") as! SKLabelNode
        bombIcon = childNodeWithName("bombIcon") as! MSButtonNode
        teleportIcon = childNodeWithName("teleportIcon") as! MSButtonNode
        explosion = SKSpriteNode(imageNamed: "GridCellNewShadow.png")
        explosion.zPosition = 8
        explosion.position = screenPosition(0, y: 0)
        explosion.hidden = true
        addChild(explosion)
        
        createGridCellArray(gridRows, gridColumns: gridColumns)
        callingBlocks()
        callingBlocks()
        callingBlocks()
        
        while true {
            let coords = createGreenCircleCoordinates()
            if gridCellSmallArray[coords.x][coords.y].isBlocked == false {
                heroPig.xCoord = coords.x
                heroPig.yCoord = coords.y
                heroPig.position = screenPosition(heroPig.xCoord, y: heroPig.yCoord)
                addChild(heroPig)
                break
            }
        }
        
       
        //Creates the number labels next to the pig at the start
        while true {
            //let random = Int(arc4random_uniform(3))
            //Above the pig for the label
            let labelCoordsUp = (x: heroPig.xCoord,  y: heroPig.yCoord + 1)
            //Below the pig for the label
            let labelCoordsDown = (x: heroPig.xCoord, y: heroPig.yCoord - 1)
            //Right of the pig for the label
            let labelCoordsRight = (x: heroPig.xCoord + 1, y: heroPig.yCoord)
            //Left of pig for the label
            let labelCoordsLeft = (x: heroPig.xCoord - 1, y: heroPig.yCoord)
                
            if checkBounds(labelCoordsUp.x, y: labelCoordsUp.y) && gridCellSmallArray[labelCoordsUp.x][labelCoordsUp.y].isBlocked == false{
                
                gridCellSmallArray[labelCoordsUp.x][labelCoordsUp.y].becomeLabelShown()
            }
            if checkBounds(labelCoordsDown.x, y: labelCoordsDown.y) && gridCellSmallArray[labelCoordsDown.x][labelCoordsDown.y].isBlocked == false{
                
                gridCellSmallArray[labelCoordsDown.x][labelCoordsDown.y].becomeLabelShown()
            }
            if checkBounds(labelCoordsRight.x, y: labelCoordsRight.y) && gridCellSmallArray[labelCoordsRight.x][labelCoordsRight.y].isBlocked == false{
                
                gridCellSmallArray[labelCoordsRight.x][labelCoordsRight.y].becomeLabelShown()
            }
//            if checkBounds(labelCoordsLeft.x, y: labelCoordsLeft.y) && gridCellSmallArray[labelCoordsLeft.x][labelCoordsLeft.y].isBlocked == false{
//                
//                gridCellSmallArray[labelCoordsLeft.x][labelCoordsLeft.y].becomeLabelShown()
//            }
            //Make sure there are always 3 point tiles at the start
            var counterTile: Int = 0
            for x in 0...gridColumns - 1{
                for y in 0...gridRows - 1{
                    if gridCellSmallArray[x][y].isGridLabel{
                        counterTile += 1
                    }
                }
            }
            switch  counterTile {
            case 1:
                createNewPointTile("Large")
                createNewPointTile("Small")
            case 2:
                createNewPointTile("Large")
            default:
                break
            }
            
                break
        }
        
        
//        pigButton.selectedHandler = {
//
//                /* Grab reference to the SpriteKit view */
//                let skView = self.view as SKView!
//                
//                /* Load Game scene */
//                let scene = Tutorial(fileNamed:"Tutorial")!
//                
//                /* Ensure correct aspect mode */
//                scene.scaleMode = .AspectFill
//                
//                /* Restart GameScene */
//                skView.presentScene(scene)
//        }

        
        
        
        //Once the bomb button is tapped, it executes the explosion animation
        bombIcon.selectedHandler = {
            if self.coinAmount >= self.bombCost{
                self.explosionAction(self.heroPig.xCoord)
            }
        }
        
        teleportIcon.selectedHandler = {
            if self.coinAmount >= self.teleportCost{
                let scaleBig = SKAction.scaleTo(1.1, duration: 0.2)
                let scaleSmall = SKAction.scaleTo(0.9, duration: 0.2)
                for x in 0...gridColumns - 1{
                    for y in 0...gridRows - 1{
                        if !self.gridCellSmallArray[x][y].isGridLabel{
                            
                            self.gridCellSmallArray[x][y].runAction(SKAction.repeatActionForever(SKAction.sequence([scaleSmall, scaleBig])))
                        }
                    }
                }
                
                self.teleportChoice = true

            }
        }
        
        betAll.selectedHandler = {
            self.betAll.state = MSButtonNodeState.MSButtonNodeStateHidden
            self.winBet()
        }
        
        
        whiteFlag.selectedHandler = {
            
            self.endGame()
        }
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self , action:
            #selector(GameScene.respondToSwipeGesture(_:)))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(GameScene.respondToSwipeGesture(_:)))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(GameScene.respondToSwipeGesture(_:)))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(GameScene.respondToSwipeGesture(_:)))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
    }
    //Calculates the screen position from a grid coordinate
    func screenPosition(x: Int, y: Int) -> CGPoint {
        let cellSizeWidth = gridCellWidth
        let cellSizeHeight = gridCellHeight
        let screenX: Double = 70.0 + Double(x) * Double(cellSizeWidth)
        let screenY: Double = 291.36 + Double(y) * Double(cellSizeHeight)
        return CGPoint(x: screenX, y: screenY)
    }
    
    //Calculates the grid coordinate from a screen position
    func gridPosition(screenX: CGFloat, screenY: CGFloat) -> (x: Int, y: Int){
        let cellSizeWidth = gridCellWidth
        let cellSizeHeight = gridCellHeight
        let gridX: Int  = Int(((screenX - 70.0) / cellSizeWidth) + 0.5)
        let gridY: Int = Int(((screenY - 291.36) / cellSizeHeight) + 0.5)
        return (x: gridX, y: gridY)
    }
    
    //Checks to see if any point is out of the grid's bounds
    func checkBounds(x: Int, y: Int) -> Bool{
        if x >= 0 && x < gridColumns && y >= 0 && y < gridRows {
            return true
        }
        return false
    }

    //To create Random Green Circle Coordinates
    func createGreenCircleCoordinates() -> (x: Int, y: Int) {
        return (Int(arc4random_uniform(UInt32(gridColumns))), Int(arc4random_uniform(UInt32(gridRows))))
    }
    
    
    //Function to spawn new number labels once pig captures one.
    func createNewPointTile(range: String){
        //Will create a small number between 5 and 10 inclusive
        let sizeSmall = Int(arc4random_uniform(6)) + 5
        //Will create a medium number between 11 and 15 inclusive
        let sizeMedium = Int(arc4random_uniform(5)) + 11
        //Will create a large number between 16 and 20
        let sizeLarge = Int(arc4random_uniform(5)) + 16
        var gridNumberTotal: Int = 10
        if range == "Small" {
            gridNumberTotal = sizeSmall
        }
        if range == "Medium" {
            gridNumberTotal = sizeMedium
        }
        if range == "Large" {
            gridNumberTotal = sizeLarge
        }
        if !isGridFull(){
            while true{
                let spawnLoc = createGreenCircleCoordinates()
                //Check to make sure new spawn tile location doesn't have block or label
                if gridCellSmallArray[spawnLoc.x][spawnLoc.y].isGridLabel == false && gridCellSmallArray[spawnLoc.x][spawnLoc.y].isBlocked == false && gridCellSmallArray[spawnLoc.x][spawnLoc.y] != gridCellSmallArray[heroPig.xCoord][heroPig.yCoord]{
                    gridCellSmallArray[spawnLoc.x][spawnLoc.y].gridNumber = 1
                    gridCellSmallArray[spawnLoc.x][spawnLoc.y].gridNumberTotal = gridNumberTotal
                    gridCellSmallArray[spawnLoc.x][spawnLoc.y].becomeLabelShown()
                    break
                }
                
            }
        }
    }
    //Will increment all of the tiles with point labels by 1 point.
    func incrementAllTiles(){
        for x in 0...gridColumns - 1{
            for y in 0...gridRows - 1{
                if gridCellSmallArray[x][y].isGridLabel {
                    if gridCellSmallArray[x][y].gridNumber < gridCellSmallArray[x][y].gridNumberTotal{
                        gridCellSmallArray[x][y].gridNumber += 1
                    }
                    else{
                        gridCellSmallArray[x][y].hideLabel()
                    }
                }
            }
        }
    }
    
    //Function to check if the whole grid is filled. Return true if grid has room
    func isGridFull() -> Bool{
        for x in 0...gridColumns - 1{
            for y in 0...gridRows - 1{
                if (gridCellSmallArray[x][y].isBlocked == false && gridCellSmallArray[x][y].isGridLabel == false && (x != heroPig.xCoord || y != heroPig.yCoord)){
                    return false
                }
            }
        }
        return true
    }
    
    
    //Checks the grid to see if there are no point tiles left and if so, spawn 1 tile. This will get called after each swupe and also turns on the bomb color switch while you have enough coins.
    func checkAllTiles(){
        var counterTile: Int = 0
        
        if coinAmount >= bombCost {
            if bombIcon.actionForKey("bomb") == nil {
                let action = SKAction.repeatActionForever(SKAction.animateWithTextures([
                    SKTexture(imageNamed: "bomb2.png"),
                    SKTexture(imageNamed: "bomb3.png"),
                    ], timePerFrame: 0.5))
                bombIcon.runAction(action, withKey: "bomb")
            }
        }
        else {
            bombIcon.removeAllActions()
            bombIcon.texture = SKTexture(imageNamed: "bomb-1.png")
        }
        
        for x in 0...gridColumns - 1{
            for y in 0...gridRows - 1{
                if gridCellSmallArray[x][y].isGridLabel{
                  counterTile += 1
                }
            }
        }
        switch  counterTile {
        case 1:
            createNewPointTile("Large")
            createNewPointTile("Small")
        case 2:
            createNewPointTile("Large")
        default:
            break
        }
    }
    
    
    
    //Called when the bomb button is tapped to mow over the piggy bank's column and destroy all of the blocks.
    func explosionAction(pigColumn: Int) {
        coinAmount -= bombCost
        explosion.removeAllActions()
        //let explosion = SKSpriteNode(imageNamed: "Explosion.png")
        let duration = 1.0
        explosion.hidden = false
        explosion.position = screenPosition(pigColumn, y: 0)
        let moveExplosion7 = SKAction.moveToY(CGFloat(screenPosition(pigColumn, y: 7).y), duration: duration)
        let scale = SKAction.scaleTo(2, duration: duration)
        
        explosion.runAction(scale)
        explosion.runAction(SKAction.sequence([
            moveExplosion7,
            SKAction.hide()
        ]))
        
        gridCellSmallArray[pigColumn][0].clear()
        
        let intervalTime = Double(duration) / Double(gridRows)
        
        for row in 0..<gridRows {
            let localRow = row
            explosion.runAction(SKAction.sequence([
                SKAction.waitForDuration(intervalTime * Double(row)),
                SKAction.runBlock({
                    self.gridCellSmallArray[pigColumn][localRow].clear()
                })
            ]))
        }
    }
    
    //Check for losing condition of when you are trapped by 4 walls when the WHITE FLAG SURRENDER Option is there
    
    //** Real losing condition is when you run out of tiles.
//    func lostTheGameCornered() -> Bool{
//        
//        //left of the piggy bank
//            let leftBlocked = !checkBounds(heroPig.xCoord - 1, y: heroPig.yCoord) || gridCellSmallArray[heroPig.xCoord - 1][heroPig.yCoord].isBlocked
//            let rightBlocked = !checkBounds(heroPig.xCoord + 1, y: heroPig.yCoord) || gridCellSmallArray[heroPig.xCoord + 1][heroPig.yCoord].isBlocked
//            let bottomBlocked = !checkBounds(heroPig.xCoord, y: heroPig.yCoord - 1) || gridCellSmallArray[heroPig.xCoord][heroPig.yCoord - 1].isBlocked
//            let aboveBlocked = !checkBounds(heroPig.xCoord, y: heroPig.yCoord + 1) || gridCellSmallArray[heroPig.xCoord][heroPig.yCoord + 1].isBlocked
//            
//            if leftBlocked && rightBlocked && bottomBlocked && aboveBlocked && coinAmount < 20{
//                //endGame()
//                return true
//            }
//        return false
//        }
    
    
    //Make question bet/surrender button and come back
    func lostTheGame() -> Bool{
        //Check grid to see if there are any point tiles left
        for x in 0...gridColumns - 1{
            for y in 0...gridRows - 1{
                if gridCellSmallArray[x][y].isGridLabel{
                    return false
                }
            }
        }
        
        endGame()
        return true
            
        }
    
//    func loseTotal() -> Bool{
//        if lostTheGame() || lostTheGameCornered() {
//            endGame()
//            return true
//        }
//        return false
//    }

    
    //Call this when the game end
    func endGame(){
        /* Change game state to game over */
        gameState = .GameOver
        
        tryAgain.state = MSButtonNodeState.MSButtonNodeStateActive
       
    }
    
    //Determines whether player wins bet or not
    
    func winBet() {
        betAll.state = MSButtonNodeState.MSButtonNodeStateHidden
        let random = CGFloat.random()
        if random < 0.6 {
            endGame()
        }
        else {
            betAll.hidden = true
            coinAmount += 50
            whiteFlag.state = MSButtonNodeState.MSButtonNodeStateActive
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            if teleportChoice == true{
    
                for x in 0...gridColumns - 1{
                    for y in 0...gridRows - 1{
                        if !gridCellSmallArray[x][y].isGridLabel{
                            
                            gridCellSmallArray[x][y].removeAllActions()
                            gridCellSmallArray[x][y].xScale = 1
                            gridCellSmallArray[x][y].yScale = 1
                        }
                    }
                }
                
                
                
                /* Grab scene position of touch */
                let location = touch.locationInNode(self)
                let locationInGrid = gridPosition(location.x, screenY: location.y)
                if checkBounds(locationInGrid.x, y: locationInGrid.y) {
                    /* Get node reference if we're touching a node */
                    let gridCell = gridCellSmallArray[locationInGrid.x][locationInGrid.y]
                    if gridCell.isBlocked == false && gridCell.isGridLabel == false && (locationInGrid.x != heroPig.xCoord || locationInGrid.y != heroPig.yCoord){
                        //Teleport Piggy Bank to touched location
                        heroPig.position = screenPosition(locationInGrid.x, y: locationInGrid.y)
                        heroPig.xCoord = locationInGrid.x
                        heroPig.yCoord = locationInGrid.y
                        self.coinAmount -= self.teleportCost

                    }
                }
            }
        }
        
        teleportChoice = false
    }
  }
