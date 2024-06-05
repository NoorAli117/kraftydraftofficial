//
//  WalkingScreenViewController.swift
//  KraftyDraftOfficial
//
//  Created by Aakif Nadeem on 04/09/2023.
//  Copyright © 2023 TechPro Solutions. All rights reserved.
//

import UIKit

class WalkingScreenViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    var nextCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage()
    }
    
    func loadImage() {
        if (nextCount <= 5) {
            self.mainImageView.image = UIImage(named: "ic_walkingScreen_\(nextCount)")
        }
        else {
            UserDefaults.standard.setValue(true, forKey: "gotoLoginView")
            if let window = AppDelegate.sharedDelegate().window {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginOptionVC")
                window.rootViewController = vc
                window.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        self.nextCount += 1
        loadImage()
    }
}
