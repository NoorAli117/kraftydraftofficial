//
//  Event.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
//
//  Wine.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
class Event {
    var _title: String?
    var _dateStart: String?
    var _eventKey: String?
    var _dateEnd: String?
    var _description: String?
    var _month: String?
    var _day: String?
    var _timeStart: String?
    var _timeEnd: String?
    
    var title: String? {
        return _title
    }
    
    var dateStart: String? {
        return _dateStart
    }
    
    var eventKey: String? {
        return _eventKey
    }
    
    var dateEnd: String? {
        return _dateEnd
    }
    
    var description: String? {
        return _description
    }
    
    var month: String? {
        return _month
    }
    
    var day: String? {
        return _day
    }
    
    var timeStart: String? {
        return _timeStart
    }
    
    var timeEnd: String? {
        return _timeEnd
    }
    
    init() {
        
    }
    
    init(title: String, dateStart: String, dateEnd: String, description: String, month: String, day: String, timeStart: String, timeEnd: String) {
        
        self._title = title
        self._dateStart = dateStart
        self._dateEnd = dateEnd
        self._description = description
        self._month = month
        self._day = day
        self._timeStart = timeStart
        self._timeEnd = timeEnd
        
    }
    
    init(postkey: String, dictionary: Dictionary<String, AnyObject>) {
        self._eventKey = eventKey
        
        if let title = dictionary["Title"] as? String {
            self._title = title
        }
        
        if let dateStart = dictionary["DateStart"] as? String {
            self._dateStart = dateStart
        }
        
        if let dateEnd = dictionary["DateEnd"] as? String {
            self._dateEnd = dateEnd
        }
        if let description = dictionary["Description"] as? String {
            self._description = description
        }
        
        if let month = dictionary["Month"] as? String {
            self._month = month
        }
        
        if let day = dictionary["Day"] as? String {
            self._day = day
        }
        if let timeStart = dictionary["TimeStart"] as? String {
            self._timeStart = timeStart
        }
        
        if let timeEnd = dictionary["TimeEnd"] as? String {
            self._timeEnd = timeEnd
        }
    }
}
