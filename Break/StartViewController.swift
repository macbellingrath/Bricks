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

class StartViewController: UIViewController {
    
    @IBOutlet weak var topScoreLabel: UILabel!
    @IBAction func play(sender:UIButton) {
        
        let gameVC = GameViewController()
       
        navigationController?.viewControllers = [gameVC]
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let label = topScoreLabel {
            let topScore = GameData.mainData().topScore
            label.text = topScore.toString()
        }
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
