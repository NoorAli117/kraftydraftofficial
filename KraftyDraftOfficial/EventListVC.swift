//
//  EventListVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit

class EventListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, EventModelProtocol {
    
    
    var selectedEvent : EventModel = EventModel()
    @IBOutlet weak var tableView: UITableView!
    
    var selectedTitle:String?
    var selectedDescription:String?
    var selectedMonth:String?
    var selectedDay:String?
    var selectedDateStart:String?
    var selectedDateEnd:String?
    var selectedTimeStart:String?
    var selectedTimeEnd:String?
    var selectedDate:String?
    var selectedTime:String?
    
    var eventItems = [Event]()
    
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)

        
        let eventModel = EventModel()
        eventModel.delegate = self
        eventModel.downloadItems()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshtable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    @objc func refreshtable(refreshControl: UIRefreshControl) {
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func itemsDownloaded(items: NSArray) {
        
        eventItems = items as! [Event]
        self.tableView.reloadData()
        activityIndicator.stopAnimating()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let events = eventItems[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Event") as? EventCell {
            
            cell.configureCell(events )
            return cell
            
        } else {
            
            return EventCell()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTitle = self.eventItems[indexPath.row].title!
        
        if (self.eventItems[indexPath.row].dateStart != "") {
            selectedDate = self.eventItems[indexPath.row].month! + " " + self.eventItems[indexPath.row].day!
        } else {
            selectedDate = "Date TBD"
        }
        
        if (self.eventItems[indexPath.row].description != "") {
            selectedDescription = self.eventItems[indexPath.row].description
        } else {
            selectedDescription = "No Description Listed"
        }
        
        if (self.eventItems[indexPath.row].timeStart != "") {
            selectedTime = self.eventItems[indexPath.row].timeStart! + " - " + self.eventItems[indexPath.row].timeEnd!
        } else {
            selectedTime = "Time TBD"
        }
        
        performSegue(withIdentifier: "EventDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventDetail" {
            
            let vc = segue.destination as! EventDetailVC
            
            vc.titleText = selectedTitle!
            vc.timeText = selectedTime!
            vc.dateText = selectedDate!
            vc.descriptionText = selectedDescription!
        }
    }
}

