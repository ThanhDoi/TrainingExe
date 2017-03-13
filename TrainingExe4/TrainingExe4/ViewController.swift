//
//  ViewController.swift
//  TrainingExe4
//
//  Created by Thanh Doi on 3/8/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var moveButton: UIButton!
    
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
            avValue += 0.1
            avResult += [avResult1]
        }
    }
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        if editButton.titleLabel?.text == "Edit" {
            editButton.setTitle("Done", for: .normal)
            editButton.isSelected = true
            moveButton.isEnabled = false
            tableView.isEditing = true
        } else {
            editButton.setTitle("Edit", for: .normal)
            editButton.isSelected = false
            moveButton.isEnabled = true
            tableView.isEditing = false
        }
    }
    
    @IBAction func moveButtonAction(_ sender: UIButton) {
        if moveButton.titleLabel?.text == "Move" {
            moveButton.setTitle("Done", for: .normal)
            moveButton.isSelected = true
            editButton.isEnabled = false
            tableView.isEditing = true
        } else {
            moveButton.setTitle("Move", for: .normal)
            moveButton.isSelected = false
            editButton.isEnabled = true
            tableView.isEditing = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAVResult()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TrainingExe4TableViewCell
        
        // Configure the cell...
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.gray
        } else {
            cell.contentView.backgroundColor = UIColor.white
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd hh:mm"
        cell.captureDateLabel.text = dateFormatter.string(from: avResult[indexPath.row].captureDate)
        cell.avValueLabel.text = "AV " + avResult[indexPath.row].avValue.description
        cell.loviValueLabel.text = "色度 " + avResult[indexPath.row].loviValue.description
        (cell.thumbnailImageView as! UIImageView).image = UIImage(named: "1")
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            avResult.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if editButton.isSelected == true {
            return .delete
        }
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = avResult[sourceIndexPath.row]
        avResult.remove(at: sourceIndexPath.row)
        avResult.insert(itemToMove, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return moveButton.isSelected
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

