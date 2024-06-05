//
//  EventHomeModel.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 4/9/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol EventHomeModelProtocol: class {
    func itemsDownloaded(events: NSArray)
}

class EventHomeModel: NSObject {
    
    //properties
    
    weak var delegate: EventHomeModelProtocol!
    
    let urlPath = "\(URL_EVENT_SMALL)"
    
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
        let EventHomes = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let EventHome = Event()
            
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
                
                EventHome._title = title
                EventHome._timeStart = timeStart
                EventHome._timeEnd = timeEnd
                EventHome._month = month
                EventHome._day = day
                EventHome._dateStart = datestart
                EventHome._dateEnd = dateend
                EventHome._description = description
                
                
            }
            
            EventHomes.add(EventHome)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(events: EventHomes)
            
        })
    }
}
