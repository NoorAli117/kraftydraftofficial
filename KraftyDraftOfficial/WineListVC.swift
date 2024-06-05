//
//  WineListVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//

import Foundation
import UIKit
class WineListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!


    
    var wine = ["Wine"]
    var win = [Wine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let wines = win[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Wine") as? WineCell {
            
            cell.configureCell(wines)
            return cell
            
        } else {
            
            return WineCell()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Wine"
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
