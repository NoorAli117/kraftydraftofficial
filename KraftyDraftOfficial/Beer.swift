//
//  Beer.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
class Beer {
    var _fullBeerNames: String?
    var _status: String?
    var _beerKey: String?
    var _abv: String?
    var _description: String?
    var _glass: String?
    var _servingSize: String?
    var _halfPour: String?
    var _growler: String?
    var _halfGrowler: String?
    //var _id: Int?
    var _id: String?
    var _breweryID: String?
    var _beerCatID: String?
    var _beerTypeID: String?
    var _rating: String?
    var _flightPrice: String?
    var _category: String?
    var _type: String?
    var _brewery: String?
    var _location: String?
    var _website: String?
    var _beerID: String?
    
    
    var fullBeerNames: String? {
        return _fullBeerNames
    }
    
    var status: String? {
        return _status
    }
    
    var beerKey: String? {
        return _beerKey
    }
    
    var abv: String? {
        return _abv
    }
    
    var description: String? {
        return _description
    }
    
    var glass: String? {
        return _glass
    }
    
    var servingSize: String? {
        return _servingSize
    }
    
    var halfPour: String? {
        return _halfPour
    }
    
    var growler: String? {
        return _growler
    }
    
    var halfGrowler: String? {
        return _halfGrowler
    }
    
//    var id: Int? {
//        return _id
//    }
    var id: String? {
        return _id
    }

    
    var breweryID: String? {
        return _breweryID
    }
    
    var beerCatID: String? {
        return _beerCatID
    }
    
    var beerTypeID: String? {
        return _beerTypeID
    }
    
    var rating: String? {
        return _rating
    }
    
    var flightPrice: String? {
        return _flightPrice
    }
    
    var category: String? {
        return _category
    }
    
    var type: String? {
        return _type
    }
    
    var brewery: String? {
        return _brewery
    }
    
    var location: String? {
        return _location
    }
    
    var website: String? {
        return _website
    }
    
    var beerID: String? {
        return _beerID
    }
    
    init() {
        
    }
    
    init(wine: String, status: String, glass: String, description: String, bottle: String, togo: String, origin: String, category: String, type: String, selection: String) {
        
        self._fullBeerNames = fullBeerNames
        self._status = status
        self._abv = abv
        self._description = description
        self._glass = glass
        self._servingSize = servingSize
        self._halfPour = halfPour
        self._growler = growler
        self._halfGrowler = halfGrowler
        self._id = id
        self._breweryID = breweryID
        self._beerCatID = beerCatID
        self._beerTypeID = beerTypeID
        self._rating = rating
        self._flightPrice = flightPrice
        self._category = category
        self._type = type
        self._brewery = brewery
        self._location = location
        self._website = website
        self._beerID = beerID

    }
    
    init(postkey: String, dictionary: Dictionary<String, AnyObject>) {
        self._beerKey = beerKey
        
        if let fullBeerNames = dictionary["FullBeerNames"] as? String {
            self._fullBeerNames = fullBeerNames
        }
        
        if let status = dictionary["Status"] as? String {
            self._status = status
        }
        
        if let abv = dictionary["ABV"] as? String {
            self._abv = abv
        }
        if let description = dictionary["Description"] as? String {
            self._description = description
        }
        
        if let glass = dictionary["Glass"] as? String {
            self._glass = glass
        }
        
        if let servingSize = dictionary["ServingSize"] as? String {
            self._servingSize = servingSize
        }
        if let halfPour = dictionary["HalfPour"] as? String {
            self._halfPour = halfPour
        }
        
        if let growler = dictionary["Growler"] as? String {
            self._growler = growler
        }
        
        if let halfGrowler = dictionary["HalfGrowler"] as? String {
            self._halfGrowler = halfGrowler
        }
        if let id = dictionary["ID"] as? String {
            self._id = id
        }
        if let breweryID = dictionary["Brewery_ID"] as? String {
            self._breweryID = breweryID
        }
        
        if let beerCatID = dictionary["BeerCat_ID"] as? String {
            self._beerCatID = beerCatID
        }
        
        if let beerTypeID = dictionary["BeerType_ID"] as? String {
            self._beerTypeID = beerTypeID
        }
        if let rating = dictionary["Rating"] as? String {
            self._rating = rating
        }
        
        if let flightPrice = dictionary["FlightPrice"] as? String {
            self._flightPrice = flightPrice
        }
        
        if let category = dictionary["Category"] as? String {
            self._category = category
        }
        if let type = dictionary["Type"] as? String {
            self._type = type
        }
        
        if let brewery = dictionary["Brewery"] as? String {
            self._brewery = brewery
        }
        
        if let location = dictionary["Location"] as? String {
            self._location = location
        }
        
        if let website = dictionary["Website"] as? String {
            self._website = website
        }
        
        if let beerID = dictionary["beer_id"] as? String {
            self._beerID = beerID
        }
    }
}
