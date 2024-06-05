//
//  EntreesModel.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/25/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol EntreeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class EntreesModel: NSObject {
    
    //properties
    
    weak var delegate: EntreeModelProtocol!
    
    let urlPath = "\(URL_FOOD_ENTREES)"
    
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
        let entrees = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let entree = Food()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let item = jsonElement["Item"] as? String,
                let short = jsonElement["Short"] as? String,
                let price = jsonElement["Price"] as? String,
//                let id = jsonElement["ID"] as? String,
                let sideIncluded = jsonElement["SideIncluded"] as? String,
                let category = jsonElement["Category"] as? String,
                let description = jsonElement["Description"] as? String
            {
                
                entree._item = item
                entree._short = short
                if (Double(price) == 0.00) {
                    entree._price = ""
                    //bulk._price = "$" + price
                } else {
                    entree._price = String(format: "$%.02f", Double(price)!)
                }
                if (description != "") {
                    entree._description = description
                } else {
                    entree._description = ""
                }
                entree._sideIncluded = sideIncluded
                entree._category = category
                
            }
            
            entrees.add(entree)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: entrees)
            
        })
    }
    
}
