//
//  EventCell.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
class EventCell: UITableViewCell {
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    var event: Event!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let f = contentView.frame
        let fr = f.inset(by: UIEdgeInsets.init(top: 2, left: 5, bottom: 2, right: 5))
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOffset = CGSize(-1, 1);
        contentView.layer.shadowOpacity = 0.5;
        
        contentView.frame = fr
    }
    
    func configureCell (_ event: Event) {
        
        self.event = event
        
        self.titleLbl.text = event.title
        self.monthLbl.text = event.month
        self.dayLbl.text = event.day
        //self.timeLbl.text = event.timeEnd
        self.timeLbl.text = "\(event.timeStart ?? "") - \(event.timeEnd ?? "")"


    }
}
