//
//  InterfaceController.swift
//  BreakWatch Extension
//
//  Created by Mac Bellingrath on 10/8/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var session: WCSession!
    var value: Float!

    @IBAction func sliderValue(value: Float) {
        
       
    let applicationData = ["sliderValue":String(value)]
        session.sendMessage(applicationData, replyHandler: { (reply: [String : AnyObject]) -> Void in
            
            }) { (error) -> Void in
                print(error)
        }

    }
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
