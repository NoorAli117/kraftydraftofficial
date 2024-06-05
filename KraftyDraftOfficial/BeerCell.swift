//
//  BeerCell.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
class BeerCell: UITableViewCell {
    
    @IBOutlet weak var BeerLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var MoreDetailsLbl: UILabel!
    @IBOutlet weak var FavBtn: UIButton!
    
    var beer: Beer!
    
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
        contentView.layer.shadowOffset = CGSize(-1, 1);
        contentView.layer.cornerRadius = 10
        //contentView.layer.shadowColor = UIColor.white.cgColor
        contentView.layer.shadowOpacity = 0.5;

        contentView.frame = fr
    }
    
    func configureCell (_ beer: Beer) {
        self.beer = beer
        
        if (beer.abv != "") {
            self.BeerLbl.text = beer.fullBeerNames! + " - " + beer.abv!
        } else {
            self.BeerLbl.text = beer.fullBeerNames
        }
        
        self.DescriptionLbl.text = beer.description
        
    }
}

extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}

