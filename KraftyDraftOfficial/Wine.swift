//
//  Wine.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
class Wine {
    var _wine: String?
    var _status: String?
    var _wineKey: String?
    var _glass: String?
    var _description: String?
    var _bottle: String?
    var _togo: String?
    var _origin: String?
    var _category: String?
    var _type: String?
    var _selection: String?
    
    var wine: String? {
        return _wine
    }
    
    var status: String? {
        return _status
    }
    
    var wineKey: String? {
        return _wineKey
    }
    
    var glass: String? {
        return _glass
    }
    
    var description: String? {
        return _description
    }
    
    var bottle: String? {
        return _bottle
    }
    
    var toGo: String? {
        return _togo
    }
    
    var origin: String? {
        return _origin
    }
    
    var category: String? {
        return _category
    }
    
    var type: String? {
        return _type
    }
    
    var selection: String? {
        return _selection
    }
    
    init() {
        
    }
    
    init(wine: String, status: String, glass: String, description: String, bottle: String, togo: String, origin: String, category: String, type: String, selection: String) {
        
        self._wine = wine
        self._status = status
        self._glass = glass
        self._description = description
        self._bottle = bottle
        self._togo = togo
        self._origin = origin
        self._category = category
        self._type = type
        self._selection = selection
        
    }
    
    init(postkey: String, dictionary: Dictionary<String, AnyObject>) {
        self._wineKey = wineKey
        
        if let wine = dictionary["Wine"] as? String {
            self._wine = wine
        }
        
        if let status = dictionary["Status"] as? String {
            self._status = status
        }
        
        if let glass = dictionary["Glass"] as? String {
            self._glass = glass
        }
        if let description = dictionary["Description"] as? String {
            self._description = description
        }
        
        if let bottle = dictionary["Bottle"] as? String {
            self._bottle = bottle
        }
        
        if let toGo = dictionary["ToGo"] as? String {
            self._togo = toGo
        }
        if let origin = dictionary["Origin"] as? String {
            self._origin = origin
        }
        
        if let category = dictionary["Category"] as? String {
            self._category = category
        }
        
        if let type = dictionary["Type"] as? String {
            self._type = type
        }
        if let selection = dictionary["Selection"] as? String {
            self._selection = selection
        }
    }
}
