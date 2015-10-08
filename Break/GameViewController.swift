//
//  GameViewController.swift
//  Break
//
//  Created by Mac Bellingrath on 10/8/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

enum BoundaryType: String {
    
    case Floor, LeftWall, RightWall, Ceiling
}

class GameViewController: UIViewController, UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate {
    
    //MARK: - Animator 
    lazy var animator: UIDynamicAnimator = {
        let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        lazilyCreatedDynamicAnimator.delegate = self
        return lazilyCreatedDynamicAnimator
        
    }()
    
    let anchor: CGPoint = CGPoint(x: 0, y: 0)
    
    var attachment: UIAttachmentBehavior?
    
    
    let topbar = GameTopBarView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
    
    let paddle = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
    let ballBehavior = UIDynamicItemBehavior()
    let brickBehavior = UIDynamicItemBehavior()
    let paddleBehavior = UIDynamicItemBehavior()
    
    let gravity = UIGravityBehavior()
    let collision = UICollisionBehavior()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background
        let bg = UIImageView(image: UIImage(named: "background"))
        bg.frame = view.frame
        view.addSubview(bg)
        
        topbar.frame.size.width = view.frame.width
        view.addSubview(topbar)
    
        
        animator.delegate = self
        
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(ballBehavior)
        animator.addBehavior(brickBehavior)
        animator.addBehavior(paddleBehavior)
        
        collision.collisionDelegate = self
        
        let ball = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        ball.layer.cornerRadius = ball.frame.width / 2
        ball.backgroundColor = UIColor.yellowColor()
        ball.center = view.center
        view.addSubview(ball)
        
        
        gravity.addItem(ball)
    
        ballBehavior.addItem(ball)

        collision.addItem(ball)
        
        
    
        collision.translatesReferenceBoundsIntoBoundary = true
        
        collision.addBoundaryWithIdentifier(BoundaryType.Ceiling.rawValue, fromPoint: CGPoint(x: 0, y: 50),toPoint: CGPoint(x: view.frame.width, y: 50))
       collision.addBoundaryWithIdentifier(BoundaryType.Floor.rawValue, fromPoint: CGPoint(x: 0, y: view.frame.height - 10),toPoint: CGPoint(x: view.frame.width, y: view.frame.height - 10))
        

        //MARK: - Push
        
        let push = UIPushBehavior(items: [ball], mode: .Instantaneous)
        push.pushDirection = CGVector(dx: 0.15, dy: 0.5)
        animator.addBehavior(push)
        
        
        //MARK: - Configure ball behavior
        ballBehavior.friction = 0
        ballBehavior.resistance = 0
        ballBehavior.elasticity = 1
        
        //MARK: - Paddle
        view.addSubview(paddle)
        paddle.backgroundColor = UIColor.blackColor()
        paddle.center = CGPoint(x: view.center.x, y: view.frame.height - 40 )
        paddleBehavior.addItem(paddle)
        collision.addItem(paddle)
//        paddleBehavior.anchored = true
        paddleBehavior.allowsRotation = false
        
        attachment = UIAttachmentBehavior(item: paddle, attachedToAnchor: paddle.center)
        animator.addBehavior(attachment!)
       
        
        
        
        //MARK: - Bricks
        
        let cols = 8
        let rows = 3
        
        let brickH = 30
        let brickSpacing = 5
        
        let totalSpacing = (cols + 1) * brickSpacing
        let brickW = (Int(view.frame.width) - totalSpacing) / cols
        
        
        
        for c in 0..<cols {
            
            for r in 0..<rows {
                
                let x = c * (brickW + brickSpacing) + brickSpacing
                let y = r * (brickH + brickSpacing) + brickSpacing + 60
                
                let brick = UIView(frame: CGRect(x: x, y: y, width: brickW, height: brickH))
                brick.backgroundColor = UIColor.whiteColor()
                brick.layer.cornerRadius = 5
                
                view.addSubview(brick)

                collision.addItem(brick)
                
                brickBehavior.addItem(brick)
            }
        }
        
        
    }
    
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
       
      
            for brick in brickBehavior.items as! [UIView] {
              
                if brick === item1  || brick === item2 {
                    
                    brickBehavior.removeItem(brick)
                    collision.removeItem(brick)
                    
                    
                    brick.removeFromSuperview()
                    
                    topbar.score += 100
            }
        }
    }
    
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        
        if let idString = identifier as? String, let boundaryName = BoundaryType(rawValue: idString) {
        
        switch boundaryName {
            
        case .Ceiling: print("I can fly high")
        case .Floor: print("I can fly low")
        case .LeftWall: print("Lefty")
        case .RightWall: print("Correct")
            
            }
        }
    }
    
    
    //MARK: - Touches
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
      
        if let touch = touches.first {
            let point = touch.locationInView(view)
            attachment?.anchorPoint.x = point.x
            
            
            
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if let touch = touches.first {
            let point = touch.locationInView(view)
            attachment?.anchorPoint.x = point.x
            
        
        }
    }
}