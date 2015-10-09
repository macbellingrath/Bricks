//
//  GameBehavior.swift
//  Break
//
//  Created by Mac Bellingrath on 10/9/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

class GameBehavior: UIDynamicBehavior {
    
    
    // MARK: Behaviors
    
    //Collision Behavior
    lazy var collisionBehavior: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
    }()
    
    // Ball Behavior
    lazy var ballBehavior: UIDynamicItemBehavior = {
        let lazilyCreatedBallBehavior = UIDynamicItemBehavior()
        lazilyCreatedBallBehavior.friction = 0
        lazilyCreatedBallBehavior.resistance = 0
        lazilyCreatedBallBehavior.elasticity = 1
        return lazilyCreatedBallBehavior
        
    }()
    
    // Gravity
    lazy var gravityBehavior:UIGravityBehavior = {
    let lazilyCreatedGravityBehavior = UIGravityBehavior()
        return lazilyCreatedGravityBehavior
    }()
    
    
    //Paddle Behavior
    lazy var paddleBehavior: UIDynamicItemBehavior = {
        let lazilycreatedPaddleBehavior = UIDynamicItemBehavior()
        lazilycreatedPaddleBehavior.allowsRotation = false
        lazilycreatedPaddleBehavior.anchored = true
        return lazilycreatedPaddleBehavior
    }()
    
    let brickBehavior = UIDynamicItemBehavior()
    

    
    override init(){
        super.init()
        addChildBehavior(gravityBehavior)
        addChildBehavior(collisionBehavior)
        addChildBehavior(ballBehavior)
        addChildBehavior(paddleBehavior)
    }
    
    func addPaddle(paddle: UIView) {
        
        if let refView = dynamicAnimator?.referenceView {
            paddle.backgroundColor = UIColor.blackColor()
            paddle.center = CGPoint(x: refView.center.x, y: refView.frame.height - 40)
    
            refView.addSubview(paddle)
            paddleBehavior.addItem(paddle)
            collisionBehavior.addItem(paddle)
        }
     
        
        
    }
    
    func removePaddle(paddle: UIView) {
        
    }
    
    func addBricks(columns: Int, rows: Int, brickHeight: Int, brickSpacing: Int) {
       
        // Bricks
        let cols = columns
        let rows = rows
        let brickH = brickHeight
        let brickSpacing = brickSpacing
        let totalSpacing = (cols + 1) * brickSpacing
       
        if let refView = dynamicAnimator?.referenceView {
        
            let brickW = (Int(refView.frame.width) - totalSpacing) / cols
           
            for c in 0..<cols {
                
                for r in 0..<rows {
                    
                    let x = c * (brickW + brickSpacing) + brickSpacing
                    let y = r * (brickH + brickSpacing) + brickSpacing + 60
                    
                    let brick = UIView(frame: CGRect(x: x, y: y, width: brickW, height: brickH))
                    brick.backgroundColor = UIColor.whiteColor()
                    brick.layer.cornerRadius = 5
                    
                    refView.addSubview(brick)
                    
                    collisionBehavior.addItem(brick)
                    
                    brickBehavior.addItem(brick)
                }
            }

        }
        
        
        
        
        
        
        
    }
    
    func addBall(ball: UIView) {
    
        ball.layer.cornerRadius = ball.frame.width / 2
        ball.backgroundColor = UIColor.yellowColor()
        dynamicAnimator?.referenceView?.addSubview(ball)
        
        
        //set balls center to view center
        if let refViewCenter = dynamicAnimator?.referenceView?.center {
            ball.center = refViewCenter
        }
        gravityBehavior.addItem(ball)
        collisionBehavior.addItem(ball)
        ballBehavior.addItem(ball)
        print("added ball")
    }
    
    func removeBall(ball: UIView){
        gravityBehavior.removeItem(ball)
        collisionBehavior.removeItem(ball)
        ballBehavior.removeItem(ball)
        ball.removeFromSuperview()
        
    }

    
}

enum BoundaryType: String {
    
    case Floor, LeftWall, RightWall, Ceiling
}