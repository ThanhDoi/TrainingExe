//
//  TrainingExe5TableViewController.swift
//  TrainingExe5
//
//  Created by Thanh Doi on 3/13/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class TrainingExe5TableViewController: UITableViewController {
    
    // MARK: Properties
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var moveButton: UIBarButtonItem!
    var editButtonIsSelected: Bool = false
    var moveButtonIsSelected: Bool = false
    
    var avResult: [AVResult] = []
    
    private func initAVResult() {
        
        let dateString = "2016.04.04 09:46"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd hh:mm"
        let date = dateFormatter.date(from: dateString)
        var avValue: Float = 2.1
        
        for _ in 1...10 {
            let loviValue = Int(arc4random_uniform(100) + 100)
            let avResult1 = AVResult(captureDate: date!, avValue: avValue, loviValue: loviValue)
            avResult += [avResult1]
            avValue += 0.1
        }
        
    }
    
    // MARK: Button's actions
    @IBAction func editButtonAction(_ sender: UIBarButtonItem) {
        if editButton.title == "Edit" {
            editButton.title = "Done"
            editButtonIsSelected = true
            moveButton.isEnabled = false
        } else {
            editButton.title = "Edit"
            editButtonIsSelected = false
            moveButton.isEnabled = true
        }
    }
    
    @IBAction func moveButtonAction(_ sender: UIBarButtonItem) {
        if moveButton.title == "Move" {
            moveButton.title = "Done"
            moveButtonIsSelected = true
            editButton.isEnabled = false
            self.tableView.isEditing = true
        } else {
            moveButton.title = "Move"
            moveButtonIsSelected = false
            editButton.isEnabled = true
            self.tableView.isEditing = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAVResult()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return avResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = ""
        if indexPath.row % 2 == 1 {
            cellIdentifier = "Cell"
        } else {
            cellIdentifier = "Cell2"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TrainingExe5TableViewCell
        
        // Configure the cell...
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.gray
        } else {
            cell.contentView.backgroundColor = UIColor.white
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd hh:mm"
        
        cell.captureDateLabel.text = dateFormatter.string(from: avResult[indexPath.row].captureDate)
        cell.avValueLabel.text = "AV " + String(avResult[indexPath.row].avValue)
        cell.loviValueLabel.text = "色度 " + String(avResult[indexPath.row].loviValue)
        cell.thumbnailImageView.image = UIImage(named: "Elekid")
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return editButtonIsSelected || moveButtonIsSelected
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            avResult.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if editButtonIsSelected {
            return .delete
        }
        return .none
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = avResult[fromIndexPath.row]
        avResult.remove(at: fromIndexPath.row)
        avResult.insert(itemToMove, at: to.row)
        tableView.reloadData()
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return moveButtonIsSelected
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "oddRowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! OddRowViewController
                destinationController.thumbnailImage = "Elekid"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY.MM.dd hh:mm"
                
                destinationController.captureDate = dateFormatter.string(from: avResult[indexPath.row].captureDate)
                destinationController.avValue = String(avResult[indexPath.row].avValue)
                destinationController.loviValue = String(avResult[indexPath.row].loviValue)
            }
        }
        
        if segue.identifier == "evenRowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! EvenRowViewController
                destinationController.thumbnailImage = "Elekid"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY.MM.dd hh:mm"
                
                destinationController.captureDate = dateFormatter.string(from: avResult[indexPath.row].captureDate)
                destinationController.avValue = String(avResult[indexPath.row].avValue)
                destinationController.loviValue = String(avResult[indexPath.row].loviValue)
            }
        }
    }
    
}
