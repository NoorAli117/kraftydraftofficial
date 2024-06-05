//
//  SideMenuTableViewController.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 3/16/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import SideMenu
import Firebase
import FirebaseAuthUI


class SideMenuTableViewController: UITableViewController {
    
    let user = Auth.auth().currentUser

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {
            return
        }
        
//        // Set up a cool background image for demo purposes
//        let imageView = UIImageView(image: UIImage(named: "saturn"))
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
//        tableView.backgroundView = imageView
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        
        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
        
        return cell
    }
    
}
