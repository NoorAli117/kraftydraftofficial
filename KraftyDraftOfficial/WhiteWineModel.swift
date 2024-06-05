//
//  WhiteWineModel.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/8/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import UIKit

protocol WhiteWineModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class WhiteWineModel: NSObject {
    
    //properties
    
    weak var delegate: WhiteWineModelProtocol!
    
    let urlPath = "\(URL_WHITE_WINE)"
    
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
        let wines = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let win = Wine()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let wine = jsonElement["Wine"] as? String,
                let description = jsonElement["Description"] as? String,
                let status = jsonElement["Status"] as? String,
                let glass = jsonElement["Glass"] as? String,
                let bottle = jsonElement["Bottle"] as? String,
                let togo = jsonElement["ToGo"] as? String,
                let origin = jsonElement["Origin"] as? String,
                let category = jsonElement["Category"] as? String,
                let type = jsonElement["Type"] as? String,
                let selection = jsonElement["Selection"] as? String
                
            {
                
                win._wine = wine
                win._description = description
                win._status = status
                win._glass = glass
                win._bottle = bottle
                win._togo = togo
                win._origin = origin
                win._category = category
                win._type = type
                win._selection = selection

            }
            
            wines.add(win)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: wines)
            
        })
    }
}

