//
//  ComplicationController.swift
//  BreakWatch Extension
//
//  Created by Mac Bellingrath on 10/8/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import ClockKit




class ComplicationController: NSObject, CLKComplicationDataSource {
    
    let text = "Hello, World"

    
    
    // MARK: - Timeline Configuration
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    
    // MARK: - Timeline Population
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        // Call the handler with the current timeline entry
        
        
        if complication.family == .ModularLarge {
            print("success")
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: text)
            template.body1TextProvider = CLKSimpleTextProvider(text: "Jo is cool")
//            template.body2TextProvider = CLKSimpleTextProvider(text: "")
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
            handler(timelineEntry)
        }
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        
        //update Hourly
        handler(NSDate(timeIntervalSinceNow: 60*60))
    }
    
    // MARK: - Placeholder Templates
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        
        // This method will be called once per supported complication, and the results will be cached
      
        
        var template: CLKComplicationTemplate? = nil
        
        switch complication.family {
           
            case .ModularSmall:
                template = nil
            case .ModularLarge:
                let modLargeTemplate = CLKComplicationTemplateModularLargeStandardBody()
                modLargeTemplate.headerTextProvider = CLKSimpleTextProvider(text: "--")
                modLargeTemplate.body1TextProvider = CLKSimpleTextProvider(text: "--")
                modLargeTemplate.body2TextProvider = CLKSimpleTextProvider(text: "--")
                template = modLargeTemplate
            case .UtilitarianSmall:
                template = nil
            case .UtilitarianLarge:
                template = nil
            case .CircularSmall:
                template = nil

   
            
        }
        print("Placeholder template success")
        handler(template)
    }
    
}
