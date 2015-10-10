//
//  GameTopBarView.swift
//  Break
//
//  Created by Mac Bellingrath on 10/8/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit


class GameTopBarView: UIView {
   
    var lives: Int = 0 {
     
        didSet {
            //change circles
            for circle in lifeView.subviews {
              
                circle.removeFromSuperview()
            }
            
            
            for l in 0..<lives {
                
                let circleTotal = lives * 10 + (lives - 1) * 5
                
                let circle = UIView(frame: CGRect(x: l * 15 - (circleTotal / 2 ), y: Int(lifeView.center.y) - 5, width: 10, height: 10))
                circle.layer.cornerRadius = 5
                circle.backgroundColor = UIColor.whiteColor()
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
    
    private let titleLabel = UILabel(frame: CGRectMake(10, 0, 100, 50))
    private let scoreLabel = UILabel(frame: CGRectMake(0, 0, 100, 50))
    private let lifeView = UIView(frame: CGRectMake(0, 0, 0, 50))
    
    override func didMoveToSuperview() {
    
        
        
        titleLabel.text = "BREAK"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Left
        
        scoreLabel.text = "0"
    
        
        scoreLabel.frame.origin.x = frame.width - 110
        
        lifeView.center.x = center.x
        lives = 3
        
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