//
//  GameData.swift
//  Break
//
//  Created by Jo Albright on 10/10/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import Foundation





//Game singleton
private let _mainData = GameData()




class GameData: NSObject, StatsViewDataSource {

    class func mainData() -> GameData { return _mainData }
    
    override init() {
        super.init()
        self.topScore = 0
        self.currentScore = 0
        self.topScore = 0
        
        
    }
    
    func getStats(game: GameData) -> [String : Int] {
        let topScore = game.topScore
        let currentScore = game.currentScore
        let currentLevel = game.currentLevel
        let statsDict = ["topScore": topScore, "currentScore": currentScore,"currentLevel":currentLevel]
        return statsDict
    }

    
    var currentScore = 0 {
        
        didSet {
            
            if currentScore > topScore { topScore = currentScore }
            
        }
        
    }
    
     var currentLevel = 0

    // levels = array of tuples where each tuple is made of 2 Int type values
   var levels: [(Int,Int)] = [
    
        (5,2), // (row,col)
        (8,2),
        (6,3),
        (9,3),
        (5,4),
        (8,4)
        
    ]
    
      var topScore: Int  {
        get {
        return getTopScore()
        }
        set {
            
                setScore(newValue)
            
        }
    }
    
    
    
    func getTopScore() -> Int {
      guard let topScore = NSUserDefaults.standardUserDefaults().objectForKey("TopScore") as? Int else {
        
            return 0
        }
        return topScore
        
    }
    
    func setScore(score: Int) {
        NSUserDefaults.standardUserDefaults().setObject(score, forKey: "TopScore")
        
    }
    
    
    private enum ScoreErrors: ErrorType {
        case NoTopScore, UnableToSetScore
    }

    
}
