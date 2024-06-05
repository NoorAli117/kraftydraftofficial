//
//  LoginOptionVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 4/22/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FirebaseEmailAuthUI
//import FBSDKCoreKit
//import FBSDKLoginKit

class LoginOptionVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let authUI = FUIAuth.defaultAuthUI() else { return }
//        ////let options = FirebaseApp.app()?.options
//        ////let clientId = options?.clientID
        authUI.delegate = self
        
        let authProviders: [FUIAuthProvider] = [
            FUIGoogleAuth(authUI: authUI),
            FUIFacebookAuth(authUI: authUI)
        ]

        authUI.providers = authProviders
        
//        let authViewController = authUI!.authViewController()
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.rootViewController = authViewController
//        window.makeKeyAndVisible()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
            if !isUserSignedIn() {
            } else {
                if Auth.auth().currentUser!.isAnonymous {
                } else {
                    performSegue(withIdentifier: "LoggedIn", sender: self)
                }
            }
    }

    
    //let user = Auth.auth().currentUser

    @IBAction func GuestBtn(_ sender: UIButton) {
        
        Auth.auth().signInAnonymously { (user, error) in
            if let error = error {
                print("Sign in failed:", error.localizedDescription)
                
            } else {
                //print ("Signed in with uid:", user!.uid)
                self.performSegue(withIdentifier: "Anonymous", sender: sender)

            }
        }
        //        performSegue(withIdentifier: "Login", sender: sender)
    }

    
    @IBAction func LoginBtn(_ sender: UIButton) {

        // get the default auth ui object
//        let authUI = FUIAuth.defaultAuthUI()
//
//        guard authUI != nil else {
//            // log the error
//            return
//        }
//
//        // set ourselves as the delegate
//        authUI?.delegate = self
//
//        // Get a reference to the auth UI view controller
//        let authVC = authUI!.authViewController()
//        let authViewController = authUI!.authViewController()
//
//
//        //show it
//        present(authViewController, animated: true, completion: nil)
////        self.performSegue(withIdentifier: "Login", sender: self)
//
    if !isUserSignedIn() {
        showLoginView()
    } else {
        if Auth.auth().currentUser!.isAnonymous {
            showLoginView()

        } else {

            performSegue(withIdentifier: "LoggedIn", sender: self)

        }
    }
        
}

private func showLoginView() {
    if let authVC = FUIAuth.defaultAuthUI()?.authViewController() {
        present(authVC, animated: true, completion: nil)
    }
}

    @IBAction func PrivacyBtn(_ sender: Any) {

        UIApplication.shared.open(NSURL(string: "http://krafty.mytechproshop.com/PPTOS/privacy.php")! as URL)
    }

    @IBAction func tosBtn(_ sender: Any) {

        UIApplication.shared.open(NSURL(string: "http://krafty.mytechproshop.com/PPTOS/terms.php")! as URL)
    }

    private func isUserSignedIn() -> Bool {
        guard Auth.auth().currentUser != nil else { return false }
        return true
    }
    
//    func application(_ app: UIApplication, open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
//      if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
//        return true
//      }
//      // other URL handling goes here.
//      return false
//    }

////
////    private func showLoginView() {
////        //if let authVC = FUIAuth.defaultAuthUI()?.authViewController() {
////            present(self, animated: true, completion: nil)
////        //}
////    }
//
//    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
//        if error != nil {
//            //Problem signing in
//
//            //login()
//        }else {
//            //User is in! Here is where we code after signing in
//            performSegue(withIdentifier: "LoggedIn", sender: self)
//
//        }
//    }
//
    
    func authUI(_ authUI: FUIAuth, didSignInWithAuthDataResult authDataResult: AuthDataResult?, error: Error?) {
      // handle user (`authDataResult.user`) and error as necessary
        if error != nil {
            //Problem signing in
            //login()
            showLoginView()

            print("test1")

        }else {
            //User is in! Here is where we code after signing in
//                if Auth.auth().currentUser!.isAnonymous {
//                    showLoginView()
//
//                } else {
            
                    performSegue(withIdentifier: "LoggedIn", sender: self)

//                }
        }
    }
    
//
//    func application(_ app: UIApplication, open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
//        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
//            return true
//        }
//        // other URL handling goes here.
//        return false
//    }
}

extension LoginOptionVC: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        if error != nil {
            return
        }
        
        performSegue(withIdentifier: "LoggedIn", sender: self)

    }
}
