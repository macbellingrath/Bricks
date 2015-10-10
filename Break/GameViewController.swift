//
//  GameViewController.swift
//  Break
//
//  Created by Mac Bellingrath on 10/8/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import AVFoundation


class GameViewController: UIViewController, UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate, AVAudioPlayerDelegate {
    
    //MARK: - Animator 
    lazy var animator: UIDynamicAnimator = {
        let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        lazilyCreatedDynamicAnimator.delegate = self
        return lazilyCreatedDynamicAnimator

    }()
    
    
    //Behaviors
    let gameBehavior = GameBehavior()
   
    var attachmentBehavior: UIAttachmentBehavior?
    
    //Anchor
    let anchor: CGPoint = CGPoint(x: 0, y: 0)
   
    //Topbar
    let topbar = GameTopBarView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
    
    //Paddle
    let paddle = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
    
    //Ball
    let ball = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    //Audio Player
    var players = [AVAudioPlayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        animator.addBehavior(gameBehavior)
        
    
        //Background
        setBackGround()
        
        
        //Topbar
        topbar.frame.size.width = self.view.frame.width
        view.addSubview(topbar)
    
        gameBehavior.addBall(ball)
        
        //Collision Behavior Configuration
        gameBehavior.collisionBehavior.collisionDelegate = self
        
        gameBehavior.collisionBehavior.addBoundaryWithIdentifier(BoundaryType.Ceiling.rawValue, fromPoint: CGPoint(x: 0, y: 50),toPoint: CGPoint(x: view.frame.width, y: 50))
        gameBehavior.collisionBehavior.addBoundaryWithIdentifier(BoundaryType.Floor.rawValue, fromPoint: CGPoint(x: 0, y: view.frame.height - 10),toPoint: CGPoint(x: view.frame.width, y: view.frame.height - 10))
        

        //Push Behavior Configuration
        let push = UIPushBehavior(items: [ball], mode: .Instantaneous)
        push.pushDirection = CGVector(dx: 0.15, dy: 0.5)
        animator.addBehavior(push)
        
        
        
        //MARK: - Paddle
        gameBehavior.addPaddle(paddle)
       
        //MARK: - Attachment Behavior
        attachmentBehavior = UIAttachmentBehavior(item: paddle, attachedToAnchor: paddle.center)
        
        animator.addBehavior(attachmentBehavior!)
        
        
        //MARK: - Brick Drawing
       gameBehavior.addBricks(8, rows: 3, brickHeight: 30, brickSpacing: 5)
       
    }
    
    
    
    
  
    
    
    //MARK: - Collision Behavior Delegate Methods
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
       
        
        for brick in gameBehavior.brickBehavior.items as! [UIView] {
           
          
            if brick === item1  || brick == item2 as! UIView {
                
                gameBehavior.brickBehavior.removeItem(brick)
                gameBehavior.collisionBehavior.removeItem(brick)
             
                brick.removeFromSuperview()

                
                topbar.score += 100
                GameData.currentScore = topbar.score
                playSound(.Confirm)
    
                }

            }
        
    }

    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        
        if let idString = identifier as? String, let boundaryName = BoundaryType(rawValue: idString) {
        
        switch boundaryName {
            
        case .Ceiling: print("I can fly high")
        case .Floor: print("I can fly low")
        
        if topbar.lives > 0 {
            //reduce lives and reset ball
            topbar.lives--
            
        } else {
            //game over
        
        }
            
            
            
        case .LeftWall: print("Lefty")
        case .RightWall: print("Correct")
            
            }
        }
    }
    
    func setBackGround() {
       
        let bg = UIImageView(image: UIImage(named: "background"))
        bg.frame = view.frame
        view.addSubview(bg)
    }
    
    //MARK: - Touches
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
      
        if let touch = touches.first {
            let point = touch.locationInView(view)
            attachmentBehavior?.anchorPoint.x = point.x
            
            
            
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if let touch = touches.first {
            let point = touch.locationInView(view)
            attachmentBehavior?.anchorPoint.x = point.x
            
        
        }
    }
    
    
    
    //MARK: - AudioPlayer
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
     
        if let index = players.indexOf(player) {
        players.removeAtIndex(index)
        print("player removed")
        }
        
    }
    
    func playSound(name: AVAudioPlayer.AssetIdentifier) {
        
        if let player = try? AVAudioPlayer(assetIdentifier: name) {
            
            player.delegate = self
            player.play()
            players.append(player)
            print(players.count)
            
        }
        
    }
    
    
    

}



    
   
extension AVAudioPlayer {
    
    enum AssetIdentifier: String {
        case Beep, Ping, Bang, Confirm
        }
        
  
        
    
        enum AssetError: ErrorType { case AssetNotFound,AssetBadData }
        
        convenience init(assetIdentifier: AssetIdentifier) throws {
            
            guard let file = NSDataAsset(name: assetIdentifier.rawValue) else { throw AssetError.AssetNotFound }
            try self.init(data: file.data)
            
        }
    
    }
    

        














