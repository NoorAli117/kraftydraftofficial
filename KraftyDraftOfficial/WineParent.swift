//
//  WineParent.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/8/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class WineParent: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        self.loadDesign()
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let controller = HomeScreenVC()
//        if #available(iOS 13.0, *) {
//            controller.isModalInPresentation = true
//        } else {
//            // Fallback on earlier versions
//        }
//        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "redwinevc")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "whitewinevc")
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
