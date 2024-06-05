//
//  Food.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
class Food {
     var _short: String?
     var _item: String?
     var _foodKey: String?
     var _price: String?
     var _description: String?
     var _sideIncluded: String?
     var _category: String?
    
    var short: String? {
        return _short
    }
    
    var item: String? {
        return _item
    }
    
    var foodKey: String? {
        return _foodKey
    }
    
    var price: String? {
        return _price
    }
    
    var description: String? {
        return _description
    }
    
    var sideIncluded: String? {
        return _sideIncluded
    }
    
    var category: String? {
        return _category
    }

    init() {
        
    }

    
    init(short: String, item: String, price: String, description: String, sideIncluded: String, category: String) {
        
        self._short = short
        self._item = item
        self._price = price
        self._description = description
        self._sideIncluded = sideIncluded
        self._category = category
        
    }
    
    init(postkey: String, dictionary: Dictionary<String, AnyObject>) {
        self._foodKey = foodKey
        
        if let short = dictionary["Short"] as? String {
            self._short = short
        }
        
        if let item = dictionary["Item"] as? String {
            self._item = item
        }
        
        if let price = dictionary["Price"] as? String {
            self._price = price
        }
        if let description = dictionary["Description"] as? String {
            self._description = description
        }
        
        if let sideIncluded = dictionary["SideIncluded"] as? String {
            self._sideIncluded = sideIncluded
        }
        
        if let category = dictionary["Category"] as? String {
            self._category = category
        }
    }
}
