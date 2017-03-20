//
//  RowDetailViewController.swift
//  TrainingExe7
//
//  Created by Thanh Doi on 3/20/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class RowDetailViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var captureDateLabel: UILabel!
    @IBOutlet weak var avValueLabel: UILabel!
    @IBOutlet weak var loviValueLabel: UILabel!
    
    var thumbnailImage: Data?
    var captureDate = ""
    var avValue = ""
    var loviValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbnailImageView.image = UIImage(data: thumbnailImage!)
        captureDateLabel.text = captureDate
        avValueLabel.text = "AV " + avValue
        loviValueLabel.text = "色度 " + loviValue
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
