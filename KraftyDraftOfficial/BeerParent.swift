//
//  BeerParent.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/8/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class BeerParent: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        self.loadDesign()
        
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "recentlytappedlistvc")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "kraftylistvc")
//        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bucketlistvc")
        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "locallistvc")
        let child_4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "seasonallistvc")
        let child_5 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "fruitylistvc")
        let child_6 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lightlistvc")
        let child_7 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "belgianlistvc")
        let child_8 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sourslistvc")
        let child_9 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "maltylistvc")
        let child_10 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hoppylistvc")
        let child_11 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "darklistvc")
        let child_12 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "comingsoonlistvc")
        return [child_1, child_2, child_3, child_4, child_5, child_6, child_7, child_8, child_9, child_10, child_11, child_12]
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

