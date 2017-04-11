//
//  LeftMenuViewController.swift
//  Assignment
//
//  Created by Thanh Doi on 4/10/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class LeftMenuViewController: UITableViewController {
    
    let items = ["musicVideo", "movie", "ebook", "audiobook", "podcast"]
    var itemSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leftMenuCell", for: indexPath) as! LeftMenuTableViewCell
        
        // Configure the cell...
        cell.label.text = items[indexPath.row]
        cell.label.textColor = UIColor.white
        cell.backgroundColor = UIColor.gray
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.revealViewController() != nil {
            let mainViewController = NetworkManager.shared.mainViewController
            self.revealViewController().pushFrontViewController(mainViewController, animated: true)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: didChosenLeftMenu), object: items[indexPath.row])
        }
    }
}
