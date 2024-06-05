//
//  BeerDetailVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit

class BeerDetailVC: UIViewController {
    
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var BreweryLbl: UILabel!
    @IBOutlet weak var LocationLbl: UILabel!
    @IBOutlet weak var TypeLbl: UILabel!
    @IBOutlet weak var CategoryLbl: UILabel!
    @IBOutlet weak var RatingLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var FlightLbl: UILabel!
    @IBOutlet weak var HalfPourLbl: UILabel!
    @IBOutlet weak var GlassLbl: UILabel!
    @IBOutlet weak var HalfGrowlerLbl: UILabel!
    @IBOutlet weak var GrowlerLbl: UILabel!
    
    var titleText: String = ""
    var breweryText: String = ""
    var locationText: String = ""
    var typeText: String = ""
    var categoryText: String = ""
    var ratingText: String = ""
    var descriptionText: String = ""
    var flightText: String = ""
    var halfPourText: String = ""
    var glassText: String = ""
    var halfGrowlerText: String = ""
    var growlerText: String = ""


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleLbl.sizeToFit()
        BreweryLbl.sizeToFit()
        LocationLbl.sizeToFit()
        TypeLbl.sizeToFit()
        CategoryLbl.sizeToFit()
        RatingLbl.sizeToFit()
        DescriptionLbl.sizeToFit()
        
        TitleLbl.text = titleText
        BreweryLbl.text = breweryText
        LocationLbl.text = locationText
        TypeLbl.text = typeText
        CategoryLbl.text = categoryText
        RatingLbl.text = ratingText
        DescriptionLbl.text = descriptionText
        FlightLbl.text = flightText
        HalfPourLbl.text = halfPourText
        GlassLbl.text = glassText
        HalfGrowlerLbl.text = halfGrowlerText
        GrowlerLbl.text = growlerText
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }


}
