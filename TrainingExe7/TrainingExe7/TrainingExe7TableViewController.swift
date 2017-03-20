//
//  TrainingExe7TableViewController.swift
//  TrainingExe7
//
//  Created by Thanh Doi on 3/20/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class TrainingExe7TableViewController: UITableViewController {
    
    // MARK: Properties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var avResults: [AVResult] = []
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var moveBarButton: UIBarButtonItem!
    var editBarButtonIsSelected: Bool = false
    var moveBarButtonIsSelected: Bool = false
    
    func getData() {
        do {
            avResults = try context.fetch(AVResult.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    @IBAction func editButtonAction(_ sender: UIBarButtonItem) {
        if editBarButton.title == "Edit" {
            editBarButton.title = "Done"
            editBarButtonIsSelected = true
            moveBarButton.isEnabled = false
        } else {
            editBarButton.title = "Edit"
            editBarButtonIsSelected = false
            moveBarButton.isEnabled = true
        }
        
    }
    
    @IBAction func moveButtonAction(_ sender: UIBarButtonItem) {
        if moveBarButton.title == "Move" {
            moveBarButton.title = "Done"
            moveBarButtonIsSelected = true
            editBarButton.isEnabled = false
            self.tableView.isEditing = true
        } else {
            moveBarButton.title = "Move"
            moveBarButtonIsSelected = false
            editBarButton.isEnabled = true
            self.tableView.isEditing = false
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return avResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TrainingExe7TableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.gray
        } else {
            cell.contentView.backgroundColor = UIColor.white
        }
        
        // Configure the cell...
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd HH:mm"
        
        if let imageData = avResults[indexPath.row].value(forKey: "image") as? Data {
            if let image = UIImage(data: imageData) {
                cell.thumbnailImageView.image = image
            }
        }
        cell.captureDateLabel.text = dateFormatter.string(from: avResults[indexPath.row].captureDate as! Date)
        cell.avValueLabel.text = "AV " + String(avResults[indexPath.row].avValue)
        cell.loviValueLabel.text = "色度 " + String(avResults[indexPath.row].loviValue)
        //cell.thumbnailImageView.image = UIImage(data: avResults[indexPath.row].image as! Data)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return editBarButtonIsSelected || moveBarButtonIsSelected
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let avResult = avResults[indexPath.row]
            context.delete(avResult)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                avResults = try context.fetch(AVResult.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
            // Delete the row from the data source
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if editBarButtonIsSelected {
            return .delete
        }
        return .none
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = avResults[fromIndexPath.row]
        avResults.remove(at: fromIndexPath.row)
        avResults.insert(itemToMove, at: to.row)
        tableView.reloadData()
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return moveBarButtonIsSelected
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewRowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RowDetailViewController
                destinationController.thumbnailImage = avResults[indexPath.row].image as Data?
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY.MM.dd hh:mm"
                
                destinationController.captureDate = dateFormatter.string(from: avResults[indexPath.row].captureDate as! Date)
                destinationController.avValue = String(avResults[indexPath.row].avValue)
                destinationController.loviValue = String(avResults[indexPath.row].loviValue)
            }
        }
    }
    
}
