//
//  CircleGeneratorFinal.swift
//  CircleFall
//
//  Created by Corey Harrilal on 7/24/16.
//  Copyright © 2016 coreyarchharrilal. All rights reserved.
//

import Foundation
import SpriteKit
//Should generate the even or odd numbered circles.

class CircleGeneratorFinal {
    
    //Generate a Green Number (player)
    static func generateGreenNumber() -> Int{
        let number = Int(arc4random_uniform(3)) + 3
        return number
    }
    //Generate a Red Number (enemy)
    static func generateRedNumber() -> Int {
        let number = Int(arc4random_uniform(2)) + 1
        return number
    }
    //Generate Prize Number
    static func generatePrizeNumber() -> Int{
        let number = Int(arc4random_uniform(10)) + 1
        return number
        }
    //Generate a Green Circle
    static func createGreenCircle() -> GreenCircle{
        //let generateGreenNumberActual = generateGreenNumber()
        let greenCircle = GreenCircle()
        return greenCircle
    }
//    //Generate a Red Circle
//    static func createRedCircle() -> RedCircle{
//        let generateRedNumberActual = generateRedNumber()
//        let redCircle = RedCircle(circleNumber: generateRedNumberActual)
//        return redCircle
//    }
//    //Generate a Prize Circle
//    static func createPrizeCircle() -> PrizeCircle{
//        let generatePrizeNumberActual = generatePrizeNumber()
//        let prizeCircle = PrizeCircle(prizeNumber: generatePrizeNumberActual)
//        return prizeCircle
//    }
}
