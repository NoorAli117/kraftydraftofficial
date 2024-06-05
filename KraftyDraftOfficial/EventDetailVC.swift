////
////  EventDetailVC.swift
////  KraftyDraftOfficial
////
////  Created by Richard Miller on 2/11/18.
////  Copyright © 2018 TechPro Solutions. All rights reserved.
////
//
import Foundation
import UIKit

class EventDetailVC: UIViewController {
    
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var TimeLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    
    var timeText: String = ""
    var titleText: String = ""
    var dateText: String = ""
    var descriptionText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleLbl.text = titleText
        TimeLbl.text = timeText
        DescriptionLbl.text = descriptionText
        DateLbl.text = dateText
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}

