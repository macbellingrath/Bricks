//
//  StartViewController.swift
//  Break
//
//  Created by Mac Bellingrath on 10/8/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

//lives lost
//bricks
//levels
//score
//
//
//startvc
//
//gamevc
//
//_with subview_
//name of game
//lives
//score
//
//
//
//score/endvc


import UIKit
//import Crashlytics

class StartViewController: UIViewController {
    
    @IBOutlet weak var topScoreLabel: UILabel! {
        didSet {
            topScoreLabel.text = GameData.mainData().topScore.toString()
            }
    }
    
    
    
    @IBAction func play(sender:UIButton) {
        print("pressed")
       
        let gameVC = GameViewController()
       
        navigationController?.viewControllers = [gameVC]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FORCE A CRASH
        let button = UIButton(type: UIButtonType.RoundedRect)
        button.frame = CGRectMake(20, 50, 100, 30)
        button.setTitle("Crash", forState: UIControlState.Normal)
        button.addTarget(self, action: "crashButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
//        func crashButtonTapped(sender: AnyObject) {
//            Crashlytics.sharedInstance().crash()
//            }

    }

    
   
}

protocol TextRepresentable {
    func toString() -> String
}

extension Int: TextRepresentable {
    func toString() -> String {
        return String(self)
    }
}
