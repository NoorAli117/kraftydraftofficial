//
//  HomeScreenVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import SideMenu
import Firebase
import FirebaseAuthUI
import UIKit

class HomeScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource, RecentlyTappedHomeModelProtocol, FoodSpecialsModelProtocol, EventHomeModelProtocol, BeerSpecialModelProtocol {
    
//class HomeScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource, RecentlyTappedHomeModelProtocol {

    var selectedEventHome : EventHomeModel = EventHomeModel()
    var selectedRecentlyTappedHome : RecentlyTappedHomeModel = RecentlyTappedHomeModel()
    var selectedFoodSpecials : FoodSpecialsModel = FoodSpecialsModel()
    var selectedBeerSpecial : BeerSpecialModel = BeerSpecialModel()
    let user = Auth.auth().currentUser
    let recentBeerModel = RecentlyTappedHomeModel()
    let eventModel = EventHomeModel()
    let beerSpecialModel = BeerSpecialModel()
    let foodSpecialModel = FoodSpecialsModel()
    
    //Beer Selected Items
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
    
    //Event Selected Items
    var selectedEventTitle:String?
    var selectedEventDescription:String?
    var selectedMonth:String?
    var selectedDay:String?
    var selectedDateStart:String?
    var selectedDateEnd:String?
    var selectedTimeStart:String?
    var selectedTimeEnd:String?
    var selectedDate:String?
    var selectedTime:String?
    
    //Food Selected Items
    var selectedFoodItem:String?
    var selectedFoodDescription:String?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //    var beerItems: NSArray = NSArray()
    var beerItems = [Beer]()
    var foodSpecialItems = [Food]()
    var eventItems = [Event]()
    var beerSpecialItems = [Beer]()

    
    let authUI = FUIAuth.defaultAuthUI()
    
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

//        let progressHUD = ProgressHUD(text: "Loading")
//        self.view.addSubview(progressHUD)
//        // All done!
//        
//        self.view.backgroundColor = UIColor.black
        
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        self.navigationItem.setHidesBackButton(true, animated: false)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshtable), for: .valueChanged)
        tableView.refreshControl = refreshControl

    }
    
    @objc func refreshtable(refreshControl: UIRefreshControl) {
        var email = user?.email
        
        if user!.isAnonymous {
            email = user?.uid
        } else {
            email = user?.email
        }

        
        recentBeerModel.downloadItems(user_id: email!)
        beerSpecialModel.downloadItems(user_id: email!)

        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

        
        //let isAnonymous = user!.isAnonymous  // true
        var email = user!.email

        if user!.isAnonymous {
            email = user?.uid
        } else {
            email = user?.email
        }
        
        if !isUserSignedIn() {
            showLoginView()
        }
        
        recentBeerModel.delegate = self
        recentBeerModel.downloadItems(user_id: email!)
        
        eventModel.delegate = self
        eventModel.downloadItems()
        
        beerSpecialModel.delegate = self
        beerSpecialModel.downloadItems(user_id: email!)
        
        foodSpecialModel.delegate = self
        foodSpecialModel.downloadItems()

        
    }
    func itemsDownloaded(recentbeer: NSArray) {
        beerItems = recentbeer as! [Beer]
        tableView.reloadData()
        activityIndicator.stopAnimating()

    }
        
    func itemsDownloaded(specialbeer: NSArray) {
        beerSpecialItems = specialbeer as! [Beer]
        tableView.reloadData()
        activityIndicator.stopAnimating()

    }
    
    func itemsDownloaded(events: NSArray) {
        eventItems = events as! [Event]
//        eventTableView.reloadData()
        tableView.reloadData()
        activityIndicator.stopAnimating()

    }
    
    func itemsDownloaded(foodspecial: NSArray) {
        foodSpecialItems = foodspecial as! [Food]
        tableView.reloadData()
        activityIndicator.stopAnimating()

    }

    private func isUserSignedIn() -> Bool {
        guard Auth.auth().currentUser != nil else { return false }
        return true
    }
    
    private func showLoginView() {
        if let authVC = FUIAuth.defaultAuthUI()?.authViewController() {
            present(authVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func navBtn(_ sender: Any) {
        
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
    }
    
    @objc func btnAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView as UIView)
        let indexPath: IndexPath! = self.tableView.indexPathForRow(at: point)
        let empty = UIImage(named: "fav_btn_empty") as UIImage?
        let full = UIImage(named: "fav_btn_full") as UIImage?
        
        
        let email = user?.email
        let beer_id = beerItems[indexPath.row].id
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
                recentBeerModel.addtofav(user_id: email!, beer_id: beer_id!, mobile: "android")
                
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
                recentBeerModel.removefromfav(user_id: email!, beer_id: beer_id!, mobile: "android")
                
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
    
    @objc func btnSpecialAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView as UIView)
        let indexPath: IndexPath! = self.tableView.indexPathForRow(at: point)
        let empty = UIImage(named: "fav_btn_empty") as UIImage?
        let full = UIImage(named: "fav_btn_full") as UIImage?
        
        
        let email = user?.email
        let beer_id = beerItems[indexPath.row].id
        
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
                beerSpecialModel.addtofav(user_id: email!, beer_id: beer_id!, mobile: "android")
                
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
                beerSpecialModel.removefromfav(user_id: email!, beer_id: beer_id!, mobile: "android")
                
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
        return 4
    }
    
//    func tableView(_ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
//        if section == 0 {
//            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
//                return "Recently Tapped"
//            } else {
//                return ""
//            }
//        } else if section == 1 {
//            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
//                return "Events"
//            } else {
//                return ""
//            }
//        } else if section == 2 {
//            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
//                return "Food Specials"
//            } else {
//                return ""
//            }
//        } else {
//            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
//                return "Beer Specials"
//            } else {
//                return ""
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return 60
            } else {
                return 0
            }
        } else if section == 1 {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return 60
            } else {
                return 0
            }
        } else if section == 2 {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return 60
            } else {
                return 0
            }
        } else {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return 60
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {

                let header = tableView.dequeueReusableCell(withIdentifier: "RecentlyTapped")! as! RecentlyTappedCell
                let f = header.contentView.frame
                let fr = f.inset(by: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10))
                header.contentView.layer.shadowOffset = CGSize(-1, 1);
                header.contentView.layer.cornerRadius = 10
                //contentView.layer.shadowColor = UIColor.white.cgColor
                header.contentView.layer.shadowOpacity = 0.5;
                
                header.contentView.frame = fr

                return header.contentView
            } else {
                return nil
            }
        } else if section == 1 {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                let header = tableView.dequeueReusableCell(withIdentifier: "EventsHome")! as! EventsHomeCell
                return header.contentView

            } else {
                return nil
            }
        } else if section == 2 {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                let header = tableView.dequeueReusableCell(withIdentifier: "FoodSpecials")! as! FoodSpecialCell
                return header.contentView
            } else {
                return nil
            }
        } else {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                let header = tableView.dequeueReusableCell(withIdentifier: "BeerSpecials")! as! BeerSpecialCell
                return header.contentView
            } else {
                return nil
            }
        }

    }

    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0 {
//            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
//
//
//                let headerImage: UIImage = UIImage(named: "recentlytapped")!
//                let headerView = UIImageView(image: headerImage)
//                let returnedView = UIView(frame: CGRect(0, 0, 100, 100))
//                returnedView.backgroundColor = UIColor.black
//                returnedView.addSubview(headerView)
//
//                return returnedView
//            } else {
//                let headerImage: UIImage = UIImage(named: "recentlyTapped")!
//                let headerView = UIImageView(image: headerImage)
//                return headerView
//            }
//        } else if section == 1 {
//            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
//                let headerImage: UIImage = UIImage(named: "upcomingevents")!
//                let headerView = UIImageView(image: headerImage)
//                let returnedView = UIView(frame: CGRect(0, 0, 100, 100))
//                returnedView.backgroundColor = UIColor.black
//                returnedView.addSubview(headerView)
//
//                return returnedView
//
//            } else {
//                return nil
//            }
//        } else if section == 2 {
//            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
//                let headerImage: UIImage = UIImage(named: "foodspecials")!
//                let headerView = UIImageView(image: headerImage)
//                let returnedView = UIView(frame: CGRect(0, 0, 100, 100))
//                returnedView.backgroundColor = UIColor.black
//                returnedView.addSubview(headerView)
//
//                return returnedView
//            } else {
//                return nil
//            }
//        } else {
//            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
//                let headerImage: UIImage = UIImage(named: "beerspecials")!
//                let headerView = UIImageView(image: headerImage)
//                let returnedView = UIView(frame: CGRect(0, 0, 100, 100))
//                returnedView.backgroundColor = UIColor.black
//                returnedView.addSubview(headerView)
//
//                return returnedView
//            } else {
//                return nil
//            }
//        }
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {

            return beerItems.count
        } else if section == 1 {
            return eventItems.count
        } else if section == 2 {
            return foodSpecialItems.count
        } else {
            return beerSpecialItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let beerspecial = beerSpecialItems[indexPath.row]
        let empty = UIImage(named: "fav_btn_empty") as UIImage?
        let full = UIImage(named: "fav_btn_full") as UIImage?
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as? EventCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentCell") as? BeerCell
        let foodCell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as? FoodCell
        let beerCell = tableView.dequeueReusableCell(withIdentifier: "BeerCell") as? BeerCell

        
        if indexPath.section == 0 {

            let beers = beerItems[indexPath.row]

            cell?.configureCell(beers)

            if (beerItems[indexPath.row].beerID == beerItems[indexPath.row].id) {
                cell?.FavBtn?.setImage(full, for: [])
            } else {
                cell?.FavBtn?.setImage(empty, for: [])
            }

            cell?.FavBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
            cell?.FavBtn.tag = indexPath.row


            return cell!

        } else if indexPath.section == 1 {
        
            let events = eventItems[indexPath.row]
            eventCell?.configureCell(events)
            return eventCell!
        } else if indexPath.section == 2 {
            let foodspecial = foodSpecialItems[indexPath.row]
            foodCell?.configureCell(foodspecial)
            return foodCell!

        } else {

            let beers = beerSpecialItems[indexPath.row]
            //let events = eventItems[indexPath.row]


            beerCell?.configureCell(beers)

            if (beerSpecialItems[indexPath.row].beerID == beerSpecialItems[indexPath.row].id) {
                beerCell?.FavBtn?.setImage(full, for: [])
            } else {
                beerCell?.FavBtn?.setImage(empty, for: [])
            }

            beerCell?.FavBtn.addTarget(self, action: #selector(btnSpecialAction(_:)), for: .touchUpInside)
            beerCell?.FavBtn.tag = indexPath.row


            return beerCell!

        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if tableView == self.recentTapTableView {
        if indexPath.section == 0 {
            //let percent = (self.beerItems[indexPath.row].abv! as NSString).floatValue
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
        
            performSegue(withIdentifier: "BeerDetail", sender: self)
        } else if indexPath.section == 1 {
//            if tableView == self.eventTableView {
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
            
        } else if indexPath.section == 2 {
            
            if (self.foodSpecialItems[indexPath.row].item != "") {
                selectedFoodItem = self.foodSpecialItems[indexPath.row].item!
            } else {
                selectedFoodItem = ""
            }
            
            if (self.foodSpecialItems[indexPath.row].description != "") {
                selectedFoodDescription = self.foodSpecialItems[indexPath.row].description
            } else {
                selectedFoodDescription = ""
            }
            
            
            performSegue(withIdentifier: "FoodDetail", sender: self)

            
        } else if indexPath.section == 3 {
            let flightDec = (self.beerSpecialItems[indexPath.row].flightPrice! as NSString).floatValue
            let glassDec = (self.beerSpecialItems[indexPath.row].glass! as NSString).floatValue
            let halfPourDec = (self.beerSpecialItems[indexPath.row].halfPour! as NSString).floatValue
            
            if (self.beerSpecialItems[indexPath.row].abv != "") {
                //            selectedTitle = self.beerItems[indexPath.row].fullBeerNames! + " - " + String(format: "%.01f", percent * 100) + "%"
                selectedTitle = self.beerSpecialItems[indexPath.row].fullBeerNames! + " - " + self.beerSpecialItems[indexPath.row].abv!
            } else {
                selectedTitle = self.beerSpecialItems[indexPath.row].fullBeerNames!
            }
            if (self.beerSpecialItems[indexPath.row].type != "") {
                selectedType = "Type: " + self.beerSpecialItems[indexPath.row].type!
            } else {
                selectedType = "Type:"
            }
            
            if (self.beerSpecialItems[indexPath.row].description != "") {
                selectedDescription = self.beerSpecialItems[indexPath.row].description
            } else {
                selectedDescription = "No Description Listed"
            }
            
            if (self.beerSpecialItems[indexPath.row].category != "") {
                selectedCategory = "Category: " + self.beerSpecialItems[indexPath.row].category!
            } else {
                selectedCategory = "Category:"
            }
            
            if (self.beerSpecialItems[indexPath.row].brewery != "") {
                selectedBrewery = "Brewery: " + self.beerSpecialItems[indexPath.row].brewery!
            } else {
                selectedBrewery = "Brewery:"
            }
            
            if (self.beerSpecialItems[indexPath.row].location != "") {
                selectedLocation = "Location: " + self.beerSpecialItems[indexPath.row].location!
            } else {
                selectedLocation = "Location:"
            }
            
            if (self.beerSpecialItems[indexPath.row].rating != "") {
                selectedRating = "Rating: " + self.beerSpecialItems[indexPath.row].rating!
            } else {
                selectedRating = "Not Yet Rated"
            }
            
            if (self.beerSpecialItems[indexPath.row].flightPrice != "") {
                selectedFlight = "Flight: $" + String(format: "%.2f", flightDec)
            } else {
                selectedFlight = "Flight:"
            }
            
            if (self.beerSpecialItems[indexPath.row].glass != "") {
                if (self.beerSpecialItems[indexPath.row].servingSize != "") {
                    selectedGlass = "Glass: $" + String(format: "%.2f", glassDec) + " (" + self.beerSpecialItems[indexPath.row].servingSize! + "oz)"
                } else {
                    selectedGlass = "Glass: $" + String(format: "%.2f", glassDec)
                }
            } else {
                selectedGlass = "Glass:"
            }

            if (self.beerSpecialItems[indexPath.row].halfPour != "") {
                selectedHalfPour = "Half Pour: $" + String(format: "%.2f", halfPourDec)
            } else {
                selectedHalfPour = "Half Pour:"
            }
            
            if (self.beerSpecialItems[indexPath.row].growler != "") {
                selectedGrowler = "Growler: $" + self.beerSpecialItems[indexPath.row].growler!
            } else {
                selectedGrowler = "Growler:"
            }
            
            if (self.beerSpecialItems[indexPath.row].halfGrowler != "") {
                selectedHalfGrowler = "Half Growler: $" + self.beerSpecialItems[indexPath.row].halfGrowler!
            } else {
                selectedHalfGrowler = "Half Growler:"
            }
            
            performSegue(withIdentifier: "BeerDetail", sender: self)

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BeerDetail" {
            
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
        } else if segue.identifier == "EventDetail" {
            
            let vc = segue.destination as! EventDetailVC
            
            vc.titleText = selectedTitle!
            vc.timeText = selectedTime!
            vc.dateText = selectedDate!
            vc.descriptionText = selectedDescription!
        } else if segue.identifier == "FoodDetail" {
            
            let vc = segue.destination as! FoodDetailVC
            
            vc.itemText = selectedFoodItem!
            vc.descriptionText = selectedFoodDescription!

        }
    }
}

extension HomeScreenVC: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
    
}
extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
