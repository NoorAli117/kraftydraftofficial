//
//  AppetizersModel.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/8/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//


import Foundation
import UIKit

protocol AppetizerModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class AppetizersModel: NSObject {
    
    //properties
    
    weak var delegate: AppetizerModelProtocol!
    
    let urlPath = "\(URL_FOOD_APPETIZERS)"
    
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
        let appetizers = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let appetizer = Food()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let item = jsonElement["Item"] as? String,
                let short = jsonElement["Short"] as? String,
                let price = jsonElement["Price"] as? String,
                let sideIncluded = jsonElement["SideIncluded"] as? String,
                let category = jsonElement["Category"] as? String,
                let description = jsonElement["Description"] as? String
            {
                
                appetizer._item = item
                appetizer._short = short
                if (Double(price) == 0.00) {
                    appetizer._price = ""
                    //bulk._price = "$" + price
                } else {
                    appetizer._price = String(format: "$%.02f", Double(price)!)
                }
                if (description != "") {
                    appetizer._description = description
                } else {
                    appetizer._description = ""
                }
                appetizer._sideIncluded = sideIncluded
                appetizer._category = category

            }
            
            appetizers.add(appetizer)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: appetizers)
            
        })
    }
    
}

