//
//  WineCell.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
class WineCell: UITableViewCell {
    
    @IBOutlet weak var WineLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var MoreLbl: UILabel!
    
    var wine: Wine!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell (_ wine: Wine) {
        
        self.wine = wine
        
        self.WineLbl.text = wine.wine
        self.DescriptionLbl.text = wine.description

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

}
