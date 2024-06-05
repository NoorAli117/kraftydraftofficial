//
//  RecentlyTappedHomeModel.swift
//  RecentlyTappedHomeDraftOfficial
//
//  Created by Richard Miller on 4/9/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol RecentlyTappedHomeModelProtocol: class {
    func itemsDownloaded(recentbeer: NSArray)
}

class RecentlyTappedHomeModel: NSObject {
    
    //properties
    
    weak var delegate: RecentlyTappedHomeModelProtocol!
    
    let urlPath = "\(URL_LAST_TAPPED)"
    let addFavUrl = "\(URL_UPDATE_FAVS)"
    let remFavUrl = "\(URL_DELETE_FAVS)"
    
    func downloadItems(user_id : String) {
        
        //let url: URL = URL(string: urlPath)!
        var url = URLRequest(url: URL(string:urlPath)!)
        url.httpMethod = "POST"
        
        let postString = "user_id="+user_id
        url.httpBody = postString.data(using: .utf8)
        
        
        
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
    
    func addtofav(user_id : String, beer_id : String, mobile : String) {
        
        let url = URL(string: "\(URL_UPDATE_FAVS)")
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let postString = "beer_id="+beer_id+"&user_id="+user_id+"&mobile="+mobile
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
            }
            
        }
        
        task.resume()
        
    }
    
    func removefromfav(user_id : String, beer_id : String, mobile : String) {
        
        let url = URL(string: "\(URL_DELETE_FAVS)")
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let postString = "beer_id="+beer_id+"&user_id="+user_id+"&mobile="+mobile
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
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
        let beers = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let beer = Beer()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let name = jsonElement["FullBeerNames"] as? String,
                let abv = jsonElement["ABV"] as? String,
                let description = jsonElement["Description"] as? String,
                let beerid = jsonElement["beer_id"] as? String,
                let id = jsonElement["ID"] as? String,
                let status = jsonElement["Status"] as? String,
                let glass = jsonElement["Glass"] as? String,
                let servingSize = jsonElement["ServingSize"] as? String,
                let halfPour = jsonElement["HalfPour"] as? String,
                let growler = jsonElement["Growler"] as? String,
                let halfGrowler = jsonElement["HalfGrowler"] as? String,
                let brewery_id = jsonElement["Brewery_ID"] as? String,
                let beercat_id = jsonElement["BeerCat_ID"] as? String,
                let beertype_id = jsonElement["BeerType_ID"] as? String,
                let rating = jsonElement["Rating"] as? String,
                let flightPrice = jsonElement["FlightPrice"] as? String,
                let category = jsonElement["Category"] as? String,
                let type = jsonElement["Type"] as? String,
                let brewery = jsonElement["Brewery"] as? String,
                let location = jsonElement["Location"] as? String,
                let website = jsonElement["Website"] as? String
                
            {
                
                beer._fullBeerNames = name
                //                beer._abv = abv
                beer._description = description
                beer._beerID = beerid
                beer._id = id
                beer._status = status
                beer._glass = glass
                beer._servingSize = servingSize
                beer._halfPour = halfPour
                beer._growler = growler
                beer._halfGrowler = halfGrowler
                beer._breweryID = brewery_id
                beer._beerCatID = beercat_id
                beer._beerTypeID = beertype_id
                beer._rating = rating
                beer._flightPrice = flightPrice
                beer._category = category
                beer._type = type
                beer._brewery = brewery
                beer._location = location
                beer._website = website
                
                let percent = (abv as NSString).floatValue
                
                if (abv != "") {
                    beer._abv = String(format: "%.01f", percent * 100) + "%"
                } else {
                    beer._abv = ""
                }

            }
            
            beers.add(beer)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(recentbeer: beers)
            
        })
    }

}
