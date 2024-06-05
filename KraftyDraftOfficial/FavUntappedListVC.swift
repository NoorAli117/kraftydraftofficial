//
//  FavUntappedListVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/31/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip
import Firebase
import FirebaseAuthUI

class FavUntappedListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FavUntappedModelProtocol {
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    var selectedFavUntapped : FavUntappedModel = FavUntappedModel()
    let user = Auth.auth().currentUser
    let beerModel = FavUntappedModel()

    @IBOutlet weak var tableView: UITableView!
    
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

    
    //    var beerItems: NSArray = NSArray()
    var beerItems = [Beer]()
    
    
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

        let beerModel = FavUntappedModel()
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
    
    override func viewDidAppear(_ animated: Bool) {
        if beerItems.count <= 0 {
            if user!.isAnonymous {

                tableView.isHidden = true
                messageLbl.isHidden = false
                loginButton.isHidden = false
                backgroundView.backgroundColor = UIColor.white
            } else {
                tableView.isHidden = false
                messageLbl.isHidden = true
                loginButton.isHidden = true
                backgroundView.backgroundColor = UIColor(red: 125/255.0, green: 10/255.0, blue: 16/255.0, alpha: 1.0)

            }
        } else {
            tableView.isHidden = false
            messageLbl.isHidden = true
            loginButton.isHidden = true
            backgroundView.backgroundColor = UIColor(red: 125/255.0, green: 10/255.0, blue: 16/255.0, alpha: 1.0)
        }
    }
//    override func viewDidAppear(_ animated: Bool) {
//        if user!.isAnonymous {
//            
//            let alert = UIAlertController(title: "Requires User Account", message: "You must login or create a user account to access Favorites.", preferredStyle: .alert)
//            let action = UIAlertAction(title: "Login", style: .default) { (action) -> Void in
//                let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "LoginOptionVC")
//                self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
//            }
//            alert.addAction(action)
//            alert.addAction(UIAlertAction(title: "Not Yet", style: UIAlertActionStyle.cancel, handler: nil))
//            alert.preferredAction = action
//            
//            self.present(alert, animated: true, completion: nil)
//            
//        }
//    }
    
    @objc func refreshtable(refreshControl: UIRefreshControl) {
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func itemsDownloaded(items: NSArray) {
        
        beerItems = items as! [Beer]
        self.tableView.reloadData()
        activityIndicator.stopAnimating()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let beers = beerItems[indexPath.row]
        let empty = UIImage(named: "fav_btn_empty") as UIImage?
        let full = UIImage(named: "fav_btn_full") as UIImage?

        if let cell = tableView.dequeueReusableCell(withIdentifier: "Beer") as? BeerCell {
            
            cell.configureCell(beers)
            
            if (beerItems[indexPath.row].beerID == beerItems[indexPath.row].id) {
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
        let beer_id = beerItems[indexPath.row].id
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // let percent = (self.beerItems[indexPath.row].abv! as NSString).floatValue
        let flightDec = (self.beerItems[indexPath.row].flightPrice! as NSString).floatValue
        let glassDec = (self.beerItems[indexPath.row].glass! as NSString).floatValue
        let halfPourDec = (self.beerItems[indexPath.row].halfPour! as NSString).floatValue
        
        
        if (self.beerItems[indexPath.row].abv != "") {
            //            selectedTitle = self.beerItems[indexPath.row].fullBeerNames! + " - " + String(format: "%.01f", percent * 100) + "%"
            selectedTitle = self.beerItems[indexPath.row].fullBeerNames! + " - " + self.beerItems[indexPath.row].abv!
        } else {
            selectedTitle = self.beerItems[indexPath.row].fullBeerNames!
        }
        if (self.beerItems[indexPath.row].type != "") {
            selectedType = "Type: " + self.beerItems[indexPath.row].type!
        } else {
            selectedType = "Type:"
        }
        
        if (self.beerItems[indexPath.row].description != "") {
            selectedDescription = self.beerItems[indexPath.row].description
        } else {
            selectedDescription = "No Description Listed"
        }
        
        if (self.beerItems[indexPath.row].category != "") {
            selectedCategory = "Category: " + self.beerItems[indexPath.row].category!
        } else {
            selectedCategory = "Category:"
        }
        
        if (self.beerItems[indexPath.row].brewery != "") {
            selectedBrewery = "Brewery: " + self.beerItems[indexPath.row].brewery!
        } else {
            selectedBrewery = "Brewery:"
        }
        
        if (self.beerItems[indexPath.row].location != "") {
            selectedLocation = "Location: " + self.beerItems[indexPath.row].location!
        } else {
            selectedLocation = "Location:"
        }
        
        if (self.beerItems[indexPath.row].rating != "") {
            selectedRating = "Rating: " + self.beerItems[indexPath.row].rating!
        } else {
            selectedRating = "Not Yet Rated"
        }
        
        if (self.beerItems[indexPath.row].flightPrice != "") {
            selectedFlight = "Flight: $" + String(format: "%.2f", flightDec)
        } else {
            selectedFlight = "Flight:"
        }
        
        if (self.beerItems[indexPath.row].glass != "") {
            if (self.beerItems[indexPath.row].servingSize != "") {
                selectedGlass = "Glass: $" + String(format: "%.2f", glassDec) + " (" + self.beerItems[indexPath.row].servingSize! + "oz)"
            } else {
                selectedGlass = "Glass: $" + String(format: "%.2f", glassDec)
            }
        } else {
            selectedGlass = "Glass:"
        }

        if (self.beerItems[indexPath.row].halfPour != "") {
            selectedHalfPour = "Half Pour: $" + String(format: "%.2f", halfPourDec)
        } else {
            selectedHalfPour = "Half Pour:"
        }
        
        if (self.beerItems[indexPath.row].growler != "") {
            selectedGrowler = "Growler: $" + self.beerItems[indexPath.row].growler!
        } else {
            selectedGrowler = "Growler:"
        }
        
        if (self.beerItems[indexPath.row].halfGrowler != "") {
            selectedHalfGrowler = "Half Growler: $" + self.beerItems[indexPath.row].halfGrowler!
        } else {
            selectedHalfGrowler = "Half Growler:"
        }

        performSegue(withIdentifier: "FavUntappedBeerDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavUntappedBeerDetail" {
            
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

    @IBAction func loginBtn(_ sender: Any) {
        let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "LoginOptionVC")
        self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)

    }
    
}

extension FavUntappedListVC : IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "UNTAPPED")
    }
}
