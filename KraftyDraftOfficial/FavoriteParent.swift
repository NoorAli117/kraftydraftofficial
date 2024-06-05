//
//  FavoriteParent.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/8/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import Firebase
import FirebaseAuthUI


class FavoriteParent: ButtonBarPagerTabStripViewController {
    
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        self.loadDesign()
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "favtappedlistvc")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "favuntappedlistvc")
        return [child_1, child_2]
    }
    
    func loadDesign() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor(red:0.49, green:0.04, blue:0.06, alpha:1.0)
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 1.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage:CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = UIColor(red:0.49, green:0.04, blue:0.06, alpha:1.0)
        }
    }
    
}
