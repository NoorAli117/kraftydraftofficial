//
//  EventModel.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/18/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol EventModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class EventModel: NSObject {
        
    //properties
    
    weak var delegate: EventModelProtocol!
    
    let urlPath = "\(URL_EVENTS)"
    
    func downloadItems() {
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)

        let task = defaultSession.dataTask(with: url) { (data, response, error) in

            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }

        }

        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let events = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let event = Event()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let title = jsonElement["Title"] as? String,
                let timeStart = jsonElement["TimeStart"] as? String,
                let timeEnd = jsonElement["TimeEnd"] as? String,
                let month = jsonElement["Month"] as? String,
                let day = jsonElement["Day"] as? String,
                let datestart = jsonElement["DateStart"] as? String,
                let dateend = jsonElement["DateEnd"] as? String,
                let description = jsonElement["Description"] as? String

                
            {
                
                event._title = title
                event._timeStart = timeStart
                event._timeEnd = timeEnd
                event._month = month
                event._day = day
                event._dateStart = datestart
                event._dateEnd = dateend
                event._description = description

                
            }
            
            events.add(event)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: events)
            
        })
    }
}
