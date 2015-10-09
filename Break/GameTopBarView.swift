//
//  GameTopBarView.swift
//  Break
//
//  Created by Mac Bellingrath on 10/8/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit


class GameTopBarView: UIView {
   
    var lives: Int = 3 {
     
        didSet {
            //change circles
            for circle in lifeView.subviews {
              
                circle.removeFromSuperview()
            }
            
            
            for l in 0..<lives {
                
                let circleTotal = lives * 10 + (lives - 1) * 5
                
                let circle = UIView(frame: CGRect(x: l * 15 - (circleTotal / 2 ), y: Int(lifeView.center.y) - 5, width: 10, height: 10))
                circle.backgroundColor = UIColor.whiteColor()
                circle.layer.cornerRadius = 5
                lifeView.addSubview(circle)
                
                
                
                
                
            }
        }
    }
    var score: Int = 0 {
        
        didSet {
            //update label
            scoreLabel.text = String(score)
            
        }
        
    }
    
   private let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: 50))
   private let scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
   private let lifeView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    
    override func didMoveToSuperview() {
    
        lives = 3
        
        titleLabel.text = "BREAK"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Left
        
        scoreLabel.text = "0"
        
        scoreLabel.frame.origin.x = frame.width - 110
        
        lifeView.frame.origin.x = frame.midX - lifeView.frame.width / 2
        
//        lifeView.backgroundColor = UIColor.whiteColor()
        
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.textAlignment = .Right
        
        
        addSubview(scoreLabel)
        addSubview(titleLabel)
        addSubview(lifeView)
        
        
    }
    
//    override func drawRect(rect: CGRect) {
//        //drawing code
//        //context
//        let context = UIGraphicsGetCurrentContext()
//        
//        
//      
//    
//    }

}