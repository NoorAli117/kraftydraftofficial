//
//  WhiteWineListVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/8/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip


class WhiteWineListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, WhiteWineModelProtocol {
    
    
    var selectedWhiteWine : WhiteWineModel = WhiteWineModel()
    @IBOutlet weak var tableView: UITableView!
    
    var selectedWine:String?
    var selectedDescription:String?
    var selectedCategory:String?
    var selectedStatus:String?
    var selectedSelection:String?
    var selectedType:String?
    var selectedToGo:String?
    var selectedOrigin:String?
    var selectedBottle:String?
    var selectedGlass:String?
    
    var wineItems = [Wine]()  
    
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

        let wineModel = WhiteWineModel()
        wineModel.delegate = self
        wineModel.downloadItems()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshtable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    @objc func refreshtable(refreshControl: UIRefreshControl) {
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func itemsDownloaded(items: NSArray) {
        
        wineItems = items as! [Wine]
        self.tableView.reloadData()
        activityIndicator.stopAnimating()

    }    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wineItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let wines = wineItems[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Wine") as? WineCell {
            
            cell.configureCell(wines )
            return cell
            
        } else {
            
            return WineCell()
        }
        
    }
    
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "Food"
    //    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let glassDec = (self.wineItems[indexPath.row].glass! as NSString).floatValue
        
        
        selectedWine = self.wineItems[indexPath.row].wine!
        
        if (self.wineItems[indexPath.row].selection != "") {
            selectedType = "Type: " + self.wineItems[indexPath.row].selection!
        } else {
            selectedType = "Type:"
        }
        
        if (self.wineItems[indexPath.row].description != "") {
            selectedDescription = self.wineItems[indexPath.row].description
        } else {
            selectedDescription = "No Description Listed"
        }
        
        if (self.wineItems[indexPath.row].origin != "") {
            selectedOrigin = "Origin: " + self.wineItems[indexPath.row].origin!
        } else {
            selectedOrigin = "Origin:"
        }
        
        if (self.wineItems[indexPath.row].toGo != "") {
            selectedToGo = "To Go: " + self.wineItems[indexPath.row].toGo!
        } else {
            selectedToGo = "To Go:"
        }
        
        if (self.wineItems[indexPath.row].bottle != "") {
            selectedBottle = "Bottle: $" + self.wineItems[indexPath.row].bottle!
        } else {
            selectedBottle = "Bottle:"
        }
        
        if (self.wineItems[indexPath.row].glass != "") {
            selectedGlass = "Glass: $" + String(format: "%.2f", glassDec)
        } else {
            selectedGlass = "Glass:"
        }
        
        if (self.wineItems[indexPath.row].selection != "") {
            selectedSelection = self.wineItems[indexPath.row].selection
        } else {
            selectedSelection = ""
        }

        performSegue(withIdentifier: "WhiteWineDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WhiteWineDetail" {
            
            let vc = segue.destination as! WineDetailVC
            
            vc.wineText = selectedWine!
            vc.bottleText = selectedBottle!
            vc.originText = selectedOrigin!
            vc.descriptionText = selectedDescription!
            vc.typeText = selectedType!
            vc.glassText = selectedGlass!
            vc.togoText = selectedToGo!
            vc.selectionText = selectedSelection!
        }
    }

}

extension WhiteWineListVC : IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "WHITE")
    }
}
