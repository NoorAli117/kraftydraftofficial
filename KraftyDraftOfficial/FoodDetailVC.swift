//
//  FoodDetailVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 4/22/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit

class FoodDetailVC: UIViewController {
    
    @IBOutlet weak var ItemLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!

    
    var itemText: String = ""
    var descriptionText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ItemLbl.sizeToFit()
        DescriptionLbl.sizeToFit()
        
        ItemLbl.text = itemText
        DescriptionLbl.text = descriptionText
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}
