//
//  ViewController.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 12/10/17.
//  Copyright © 2017 TechPro Solutions. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseEmailAuthUI

class ViewController: UIViewController, AuthUIDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        let authUI = FUIAuth.defaultAuthUI()
        ////let options = FirebaseApp.app()?.options
        ////let clientId = options?.clientID
        authUI?.delegate = self as? FUIAuthDelegate
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIEmailAuth()]
//            FUIFacebookAuth()]
        authUI?.providers = providers
        let authViewController = authUI!.authViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = authViewController
        window.makeKeyAndVisible()
        //present(authViewController, animated: true, completion: nil)
        
//        let kFirebaseTermsOfService = URL(string: URL_TERMS_SERV)!
//        authUI?.tosurl = kFirebaseTermsOfService

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isUserSignedIn() {
            showLoginView()
        } else {
            if Auth.auth().currentUser!.isAnonymous {
                showLoginView()

            } else {

                performSegue(withIdentifier: "LoggedIn2", sender: self)

            }
        }
    }
    
    private func isUserSignedIn() -> Bool {
        guard Auth.auth().currentUser != nil else { return false }
        return true
    }
    
    private func showLoginView() {
        if let authVC = FUIAuth.defaultAuthUI()?.authViewController() {
            present(authVC, animated: true, completion: nil)
        }
    }


    
//    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
//        if error != nil {
//            //Problem signing in
//            //login()
//        }else {
//            //User is in! Here is where we code after signing in
//            performSegue(withIdentifier: "LoggedIn2", sender: self)
//
//        }
//    }
    
    func authUI(_ authUI: FUIAuth, didSignInWithAuthDataResult authDataResult: AuthDataResult?, error: Error?) {
      // handle user (`authDataResult.user`) and error as necessary
        if error != nil {
            //Problem signing in
            //login()
        }else {
            //User is in! Here is where we code after signing in
            if !isUserSignedIn() {
                showLoginView()
            } else {
                if Auth.auth().currentUser!.isAnonymous {
                    showLoginView()

                } else {

                    performSegue(withIdentifier: "LoggedIn2", sender: self)

                }
            }
        }
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if !isUserSignedIn() {
            showLoginView()
        } else {
//            if Auth.auth().currentUser!.isAnonymous {
//                showLoginView()
//
//            } else {
//
//                if !isUserSignedIn() {
//                    showLoginView()
//                } else {
//                    if Auth.auth().currentUser!.isAnonymous {
//                        showLoginView()
//
//                    } else {

                        performSegue(withIdentifier: "LoggedIn2", sender: self)

//                    }
//                }
//            }
        }
    }

    
//    //var db = FIRDatabaseReference.init()
//    var kFacebookAppID = "PLACE YOUR 16-DIGIT FACEBOOK SECRET HERE (FOUND IN FIREBASE CONSOLE UNDER AUTHENTICATION)"
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //FIRApp.configure()
//        checkLoggedIn()
//        
//        
//    }
//    
//    func checkLoggedIn() {
//        Auth.auth().addStateDidChangeListener { auth, user in
//            if user != nil {
//                // User is signed in.
//            } else {
//                // No user is signed in.
//                self.login()
//            }
//        }
//    }
//    
//    func login() {
//        FirebaseApp.configure()
//        let authUI = FUIAuth.defaultAuthUI()
//        let options = FirebaseApp.app()?.options
//        let clientId = options?.clientID
//        authUI?.delegate = self as? FUIAuthDelegate
//        let providers: [FUIAuthProvider] = [
//            FUIGoogleAuth(),
//            FUIFacebookAuth()]
//        authUI.providers = providers
//        let authViewController = authUI!.authViewController()
//        self.present(authViewController, animated: true, completion: nil)
//    }
//    
//    @IBAction func logoutUser(_ sender: AnyObject) {
//        authUI.signOut()
//    }
//    
//    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
//        if error != nil {
//            //Problem signing in
//            login()
//        }else {
//            //User is in! Here is where we code after signing in
//            
//        }
//    }
//    
//    func application(_ app: UIApplication, open url: URL,
//                     options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
//        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
//        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
//            return true
//        }
//        // other URL handling goes here.
//        return false
//    }
    
}
