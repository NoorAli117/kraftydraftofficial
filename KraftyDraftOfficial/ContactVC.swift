//
//  ContactVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit

class ContactVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func callBtn(_ sender: Any) {
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "tel://8035672812")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: "tel://8035672812")!)
        }

        //UIApplication.shared.openURL(URL(string: "tel://8035672812")!)

    }
    
    @IBAction func directionsBtn(_ sender: Any) {
        
        let url = URL(string: "https://maps.apple.com/?daddr=33.987917,-81.305494")
        if UIApplication.shared.canOpenURL(url!) {
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url!)
            }

            
            //UIApplication.shared.openURL(url!)
            
        } else {
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "https://maps.google.com/?daddr=33.987917,-81.305494")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: "https://maps.google.com/?daddr=33.987917,-81.305494")!)
            }

            
            //UIApplication.shared.openURL(URL(string: "https://maps.google.com/?daddr=33.987917,-81.305494")!)
            
        }
        
    }
 
    @IBAction func websiteBtn(_ sender: Any) {
        
        //let strWS = "http://www.kraftydraft.com/"
        //let strWS = "https://squareup.com/store/krafty-draft-brew-pub-llc"
        let strWS = "https://heartlandgiftcard.com/mobile/CheckBalance.aspx"
        performSegue(withIdentifier: "Website", sender: strWS)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Website" {
            if let siteVC = segue.destination as? WebsiteVC {
                if let theString = sender as? String {
                    siteVC.transferText = theString
                }
            }
        }
    }

    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
