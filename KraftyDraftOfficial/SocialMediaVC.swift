//
//  SocialMediaVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit


class SocialMediaVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
    }
    
    @IBAction func facebookBtn(_ sender: AnyObject) {
        
        
        UIApplication.tryURL(urls: [
            "fb://profile/798793393488312", // App
            "http://www.facebook.com/798793393488312" // Website if app fails
            ])

        
//        let Username =  "798793393488312"
//        let appURL = URL(string: "fb://profile/\(Username)")!
//        let webURL = URL(string: "https://www.facebook.com/pg/Krafty-Draft-Brew-Pub-LLC-798793393488312/about/?ref=page_internal")!
//
//        if UIApplication.shared.canOpenURL(appURL) {
////            if #available(iOS 10.0, *) {
////                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
////            } else {
////                UIApplication.shared.openURL(webURL)
////            }
//            
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
//            } else {
//                UIApplication.shared.openURL(appURL)
//            }
//
//        } else {
//            //redirect to safari because the user doesn't have Instagram
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
//            } else {
//                UIApplication.shared.openURL(webURL)
//            }
//        }
//
    }
    
    @IBAction func instagramBtn(_ sender: AnyObject) {
        
        let instagram = "https://www.instagram.com/explore/locations/363246561/krafty-draft-brew-pub-llc/?hl=en"
        let instagramUrl = URL(string: instagram)!
        //let instagramDefaultUrl = URL(string: "http://instagram.com/")!
        if UIApplication.shared.canOpenURL(instagramUrl)
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(instagramUrl, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(instagramUrl)
            }

            //UIApplication.shared.openURL(instagramUrl!)
            
        } else {
            //redirect to safari because the user doesn't have facebook
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(instagramUrl, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(instagramUrl)
            }

            //UIApplication.shared.openURL(URL(string: "http://instagram.com/")!)
        }
        
    }
    
    @IBAction func twitterBtn(_ sender: AnyObject) {
        
//        let twitter = "https://twitter.com/#!/KraftyDraft"
//        let twitterUrl = URL(string: twitter)
//        if UIApplication.shared.canOpenURL(twitterUrl!)
//        {
//            UIApplication.shared.openURL(twitterUrl!)
//
//        } else {
//            //redirect to safari because the user doesn't have facebook
//            UIApplication.shared.openURL(URL(string: "http://twitter.com/")!)
//        }
        
        let screenName =  "KraftyDraft"
        let appURL = URL(string: "twitter://user?screen_name=\(screenName)")!
        let webURL = URL(string: "https://twitter.com/\(screenName)")!

        
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
            //redirect to safari because the user doesn't have Instagram
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(webURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(webURL)
            }
        }
    }
    
}

extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                            if #available(iOS 10.0, *) {
                                application.open(URL(string: url)!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                            } else {
                                application.openURL(URL(string: url)!)
                            }

                //application.openURL(URL(string: url)!)
                return
            }
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
