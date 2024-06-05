//
//  SettingsVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 4/8/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI


class SettingsVC: UIViewController {
    
    let authUI = FUIAuth.defaultAuthUI()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func notificationBfn(_ sender: UIButton) {
        
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print(settingsUrl)
                print("Settings opened: \(success)") // Prints true
            })
        }
        
        
    }
    @IBAction func logoutBtn(_ sender: Any) {
        
        do {
            try authUI?.signOut()
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginOptionVC") as! LoginOptionVC
            self.present(viewController, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

    }
    
    @IBAction func privacyBtn(_ sender: Any) {
        
        
    }
    
    @IBAction func termsBtn(_ sender: Any) {
        
        
    }
    
//    @IBAction func subBtn(_ sender: Any) {
//        Messaging.messaging().subscribe(toTopic: "favorites/1304")
//        //Messaging.messaging().subscribe(toTopic: "favorites/242")
//        Messaging.messaging().subscribe(toTopic: "favoritebeer")
//
//    }
//
//    
//    @IBAction func unSubBtn(_ sender: Any) {
//        Messaging.messaging().unsubscribe(fromTopic: "favorites")
//    }
}
