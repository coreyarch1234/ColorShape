//
//  CircleGenerator .swift
//  CircleFall
//
//  Created by Corey Harrilal on 7/12/16.
//  Copyright © 2016 coreyarchharrilal. All rights reserved.
//

import Foundation
import SpriteKit
//Should generate the even or odd numbered circles.

class CircleGenerator {
    
    static func generateNumber() -> (Int, SKColor) {

        let number = Int(arc4random_uniform(2)) + 1
        let random = [3, 6 , 9 , 10, 25] // 60% chance of being blue
        let randomRandom = Int(arc4random_uniform(4)) + 1

        if random[randomRandom] % 3 == 0 {
            return (number, SKColor.blueColor())
        }
        return (number, SKColor.redColor())

    }
     static func createCircle() -> TypeCircle {
        //Create circle instance
        let generateTuple = generateNumber()
        let newCircle = TypeCircle(color:generateTuple.1, circleNumber:generateTuple.0)
        return newCircle
    }
}