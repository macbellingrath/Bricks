//
//  StatsViewController.swift
//  Break
//
//  Created by Mac Bellingrath on 10/10/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit


@IBDesignable
class StatsView: UIView {
    
    @IBOutlet weak var topScoreLabel: UILabel! {
        didSet {
            topScoreLabel.text = GameData.mainData().topScore.toString()
        }
    }
    
    weak var delegate: StatsViewDataSource?
    
    
    
 
    
    
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
    }

  


}


protocol StatsViewDataSource: class {
    
    func getStats(game: GameData) -> [String: Int]
    
    
}