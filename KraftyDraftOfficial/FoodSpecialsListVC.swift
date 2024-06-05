//
//  FoodSpecialsListVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 8/19/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip


class FoodSpecialsListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FoodSpecialsModelProtocol {
    
    
    var selectedFoodSpecials : FoodSpecialsModel = FoodSpecialsModel()
    
    var selectedItem:String?
    var selectedDescription:String?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var EmptyListLbl: UILabel!
    
    
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
        
        let foodModel = FoodSpecialsModel()
        foodModel.delegate = self
        foodModel.downloadItems()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshtable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    @objc func refreshtable(refreshControl: UIRefreshControl) {
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func itemsDownloaded(foodspecial: NSArray) {
        
        foodItems = foodspecial as! [Food]
        self.tableView.reloadData()
        if foodItems.count > 0 {
            EmptyListLbl.isHidden = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.EmptyListLbl.isHidden = false
                self.EmptyListLbl.textColor = UIColor.white
                self.EmptyListLbl.text = "There Are Currently No Specials. Check Back Later."
            }
        }
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
        
        
        performSegue(withIdentifier: "FoodSpecialDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FoodSpecialDetail" {
            
            let vc = segue.destination as! FoodDetailVC
            
            vc.itemText = selectedItem!
            vc.descriptionText = selectedDescription!
        }
    }
}

extension FoodSpecialsListVC : IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "SPECIALS")
    }
}
