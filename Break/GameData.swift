//
//  GameData.swift
//  Break
//
//  Created by Jo Albright on 10/10/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import Foundation

private let _mainData = GameData()

class GameData: NSObject {

    class func mainData() -> GameData { return _mainData }
    
    
    
   static var currentScore = 0 {
        
        didSet {
            
            if currentScore > topScore { topScore = currentScore }
            
        }
        
    }
    
    static var currentLevel = 0

    // levels = array of tuples where each tuple is made of 2 Int type values
    var levels: [(Int,Int)] = [
    
        (5,2), // (row,col)
        (8,2),
        (6,3),
        (9,3),
        (5,4),
        (8,4)
        
    ]
    
    static var topScore: Int? {
        get {
        return try? getTopScore()
        }
        set {
            if let score = newValue {
                setTopScore(score)
            }
        }
    }
    
    
    class func getTopScore() throws -> Int {
        guard let topScore = NSUserDefaults.standardUserDefaults().objectForKey("TopScore") as? Int else {
            throw ScoreErrors.NoTopScore
        }
        return topScore
        
    }
    
    class func setTopScore(score: Int) {
        NSUserDefaults.standardUserDefaults().setObject(score, forKey: "TopScore")
        
    }
    
    
    private enum ScoreErrors: ErrorType {
        case NoTopScore, UnableToSetScore
    }

    
}
