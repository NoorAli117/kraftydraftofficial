//
//  AppetizersListVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/8/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip


class AppetizersListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, AppetizerModelProtocol {
    
    
    var selectedAppetizer : AppetizersModel = AppetizersModel()
    
    var selectedItem:String?
    var selectedDescription:String?

    @IBOutlet weak var tableView: UITableView!
    
    //var food = ["Food"]
    //var foo = [Food]()
    //var foodItems: NSArray = NSArray()
    var foodItems = [Food]()
    
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)

//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 125.0

        let foodModel = AppetizersModel()
        foodModel.delegate = self
        foodModel.downloadItems()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshtable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.estimatedRowHeight = 200
//
//        tableView.rowHeight = UITableViewAutomaticDimension
//
//    }
    
    @objc func refreshtable(refreshControl: UIRefreshControl) {
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func itemsDownloaded(items: NSArray) {
        
        foodItems = items as! [Food]
        self.tableView.reloadData()
        activityIndicator.stopAnimating()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let foods = foodItems[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Food") as? FoodCell {
            
            cell.configureCell(foods )
            return cell
            
        } else {
            
            return FoodCell()
        }
        
    }
    
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "Food"
    //    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (self.foodItems[indexPath.row].item != "") {
            selectedItem = self.foodItems[indexPath.row].item!
        } else {
            selectedItem = ""
        }
        
        if (self.foodItems[indexPath.row].description != "") {
            selectedDescription = self.foodItems[indexPath.row].description
        } else {
            selectedDescription = ""
        }
        
        
        performSegue(withIdentifier: "AppetizerDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AppetizerDetail" {
            
            let vc = segue.destination as! FoodDetailVC
            
            vc.itemText = selectedItem!
            vc.descriptionText = selectedDescription!
        }
    }
}

extension AppetizersListVC : IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "APPETIZERS")
    }
}

