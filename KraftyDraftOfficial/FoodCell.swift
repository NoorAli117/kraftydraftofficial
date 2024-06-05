//
//  FoodCell.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
class FoodCell: UITableViewCell {
    
    
    @IBOutlet weak var FoodLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    
    
    var food: Food!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell (_ food: Food) {
        self.food = food
        
        self.FoodLbl.text = food.item
        self.DescriptionLbl.text = food.description
        self.PriceLbl.text = food.price
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let f = contentView.frame
        let fr = f.inset(by: UIEdgeInsets.init(top: 3, left: 3, bottom: 1, right: 3))
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOffset = CGSize(-1, 1);
        contentView.layer.shadowOpacity = 0.5;
        
        contentView.frame = fr
    }

}
