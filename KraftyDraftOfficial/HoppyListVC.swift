//
//  HoppyListVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/8/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip
import Firebase
import FirebaseAuthUI

class HoppyListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, HoppyModelProtocol, UISearchBarDelegate {
    
    var selectedHoppy : HoppyModel = HoppyModel()
    let user = Auth.auth().currentUser
    let beerModel = HoppyModel()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedTitle:String?
    var selectedDescription:String?
    var selectedCategory:String?
    var selectedBrewery:String?
    var selectedLocation:String?
    var selectedType:String?
    var selectedFlight:String?
    var selectedGrowler:String?
    var selectedHalfGrowler:String?
    var selectedHalfPour:String?
    var selectedGlass:String?
    var selectedRating:String?

    
    var filteredBeerItems = [Beer]()
    var beerItems = [Beer]()
    
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)

        let beerModel = HoppyModel()
        beerModel.delegate = self
        var email = user?.email
        
        if user!.isAnonymous {
            email = user?.uid
        } else {
            email = user?.email
        }
        beerModel.downloadItems(user_id: email!)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshtable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    @objc func refreshtable(refreshControl: UIRefreshControl) {
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func itemsDownloaded(items: NSArray) {
        
        beerItems = items as! [Beer]
        filteredBeerItems = beerItems
        self.tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBeerItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let beers = filteredBeerItems[indexPath.row]
        let empty = UIImage(named: "fav_btn_empty") as UIImage?
        let full = UIImage(named: "fav_btn_full") as UIImage?

        if let cell = tableView.dequeueReusableCell(withIdentifier: "Beer") as? BeerCell {
            
            cell.configureCell(beers)
            
            if (filteredBeerItems[indexPath.row].beerID == filteredBeerItems[indexPath.row].id) {
                cell.FavBtn?.setImage(full, for: [])
            } else {
                cell.FavBtn?.setImage(empty, for: [])
            }

            cell.FavBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
            cell.FavBtn.tag = indexPath.row
            
            return cell
            
        } else {
            
            return BeerCell()
        }
        
    }
    
    @objc func btnAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView as UIView)
        let indexPath: IndexPath! = self.tableView.indexPathForRow(at: point)
        let empty = UIImage(named: "fav_btn_empty") as UIImage?
        let full = UIImage(named: "fav_btn_full") as UIImage?

        let email = user?.email
        let beer_id = filteredBeerItems[indexPath.row].id
        
        if user!.isAnonymous {
            
            let alert = UIAlertController(title: "Requires User Account", message: "You must login or create a user account to add to Favorites.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Login", style: .default) { (action) -> Void in
                let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "LoginOptionVC")
                self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
            }
            alert.addAction(action)
            alert.addAction(UIAlertAction(title: "Not Yet", style: UIAlertAction.Style.cancel, handler: nil))
            alert.preferredAction = action

            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            
            if (sender.currentImage?.isEqual(empty))! {
                sender.setImage(full, for: .normal)
                beerModel.addtofav(user_id: email!, beer_id: beer_id!, mobile: "android")
                
                let message = "Added To Favorites"
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                self.present(alert, animated: true)
                
                // duration in seconds
                let duration: Double = 0.5
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                    alert.dismiss(animated: true)
                }
                
                
            } else {
                sender.setImage(empty, for: .normal)
                beerModel.removefromfav(user_id: email!, beer_id: beer_id!, mobile: "android")
                
                let message = "Removed From Favorites"
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                self.present(alert, animated: true)
                
                // duration in seconds
                let duration: Double = 0.5
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                    alert.dismiss(animated: true)
                }
                
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let percent = (self.beerItems[indexPath.row].abv! as NSString).floatValue
        let flightDec = (self.filteredBeerItems[indexPath.row].flightPrice! as NSString).floatValue
        let glassDec = (self.filteredBeerItems[indexPath.row].glass! as NSString).floatValue
        let halfPourDec = (self.filteredBeerItems[indexPath.row].halfPour! as NSString).floatValue
        
        if (self.filteredBeerItems[indexPath.row].abv != "") {
            //            selectedTitle = self.beerItems[indexPath.row].fullBeerNames! + " - " + String(format: "%.01f", percent * 100) + "%"
            selectedTitle = self.filteredBeerItems[indexPath.row].fullBeerNames! + " - " + self.filteredBeerItems[indexPath.row].abv!
        } else {
            selectedTitle = self.filteredBeerItems[indexPath.row].fullBeerNames!
        }
        if (self.filteredBeerItems[indexPath.row].type != "") {
            selectedType = "Type: " + self.filteredBeerItems[indexPath.row].type!
        } else {
            selectedType = "Type:"
        }
        
        if (self.filteredBeerItems[indexPath.row].description != "") {
            selectedDescription = self.filteredBeerItems[indexPath.row].description
        } else {
            selectedDescription = "No Description Listed"
        }
        
        if (self.filteredBeerItems[indexPath.row].category != "") {
            selectedCategory = "Category: " + self.filteredBeerItems[indexPath.row].category!
        } else {
            selectedCategory = "Category:"
        }
        
        if (self.filteredBeerItems[indexPath.row].brewery != "") {
            selectedBrewery = "Brewery: " + self.filteredBeerItems[indexPath.row].brewery!
        } else {
            selectedBrewery = "Brewery:"
        }
        
        if (self.filteredBeerItems[indexPath.row].location != "") {
            selectedLocation = "Location: " + self.filteredBeerItems[indexPath.row].location!
        } else {
            selectedLocation = "Location:"
        }
        
        if (self.filteredBeerItems[indexPath.row].rating != "") {
            selectedRating = "Rating: " + self.filteredBeerItems[indexPath.row].rating!
        } else {
            selectedRating = "Not Yet Rated"
        }
        
        if (self.filteredBeerItems[indexPath.row].flightPrice != "") {
            selectedFlight = "Flight: $" + String(format: "%.2f", flightDec)
        } else {
            selectedFlight = "Flight:"
        }
        
        if (self.filteredBeerItems[indexPath.row].glass != "") {
            if (self.filteredBeerItems[indexPath.row].servingSize != "") {
                selectedGlass = "Glass: $" + String(format: "%.2f", glassDec) + " (" + self.filteredBeerItems[indexPath.row].servingSize! + "oz)"
            } else {
                selectedGlass = "Glass: $" + String(format: "%.2f", glassDec)
            }
        } else {
            selectedGlass = "Glass:"
        }

        if (self.filteredBeerItems[indexPath.row].halfPour != "") {
            selectedHalfPour = "Half Pour: $" + String(format: "%.2f", halfPourDec)
        } else {
            selectedHalfPour = "Half Pour:"
        }
        
        if (self.filteredBeerItems[indexPath.row].growler != "") {
            selectedGrowler = "Growler: $" + self.filteredBeerItems[indexPath.row].growler!
        } else {
            selectedGrowler = "Growler:"
        }
        
        if (self.filteredBeerItems[indexPath.row].halfGrowler != "") {
            selectedHalfGrowler = "Half Growler: $" + self.filteredBeerItems[indexPath.row].halfGrowler!
        } else {
            selectedHalfGrowler = "Half Growler:"
        }

        performSegue(withIdentifier: "HoppyBeerDetail", sender: self)
        
    }
    
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredBeerItems = beerItems
        } else {
            filteredBeerItems = beerItems.filter { $0.fullBeerNames?.lowercased().contains(searchText.lowercased()) ?? false }
        }
        tableView.reloadData()
    }
    
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HoppyBeerDetail" {
            
            let vc = segue.destination as! BeerDetailVC
            
            vc.titleText = selectedTitle!
            vc.breweryText = selectedBrewery!
            vc.locationText = selectedLocation!
            vc.descriptionText = selectedDescription!
            vc.typeText = selectedType!
            vc.glassText = selectedGlass!
            vc.growlerText = selectedGrowler!
            vc.halfGrowlerText = selectedHalfGrowler!
            vc.halfPourText = selectedHalfPour!
            vc.flightText = selectedFlight!
            vc.ratingText = selectedRating!
            vc.categoryText = selectedCategory!
        }
    }

}

extension HoppyListVC : IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "HOPPY")
    }
}


