//
//  WineDetailVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit

class WineDetailVC: UIViewController {
    
    @IBOutlet weak var WineLbl: UILabel!
    @IBOutlet weak var ToGoLbl: UILabel!
    @IBOutlet weak var OriginLbl: UILabel!
    @IBOutlet weak var TypeLbl: UILabel!
    @IBOutlet weak var BottleLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var GlassLbl: UILabel!
    
    var wineText: String = ""
    var bottleText: String = ""
    var originText: String = ""
    var typeText: String = ""
    var categoryText: String = ""
    var togoText: String = ""
    var descriptionText: String = ""
    var selectionText: String = ""
    var glassText: String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        WineLbl.text = wineText
        ToGoLbl.text = togoText
        OriginLbl.text = originText
        TypeLbl.text = typeText
        BottleLbl.text = bottleText
        GlassLbl.text = glassText
        DescriptionLbl.text = descriptionText
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}

