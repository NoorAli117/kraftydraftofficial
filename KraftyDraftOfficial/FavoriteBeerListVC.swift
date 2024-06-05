//
//  FavoriteBeerListVC.swift
//  KraftyDraftOfficial
//
//  Created by Richard Miller on 2/11/18.
//  Copyright © 2018 TechPro Solutions. All rights reserved.
//
import UIKit
import Foundation

class FavoriteBeerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var beer = ["Beer"]
    var ber = [Beer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let beers = ber[indexPath.row]

                if let cell = tableView.dequeueReusableCell(withIdentifier: "Beer") as? BeerCell {
                    
                    cell.configureCell(beers)
                    return cell
                    
                } else {
                    
                    return BeerCell()
                }
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Beer"
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    


}
