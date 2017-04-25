//
//  CellDeltailViewController.swift
//  Assignment
//
//  Created by Thanh Doi on 4/11/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class CellDeltailViewController: UIViewController {

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var media: Media?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        thumbnailImage.image = UIImage(data: (media?.imageData)!)
        trackNameLabel.text = media?.trackName
        artistNameLabel.text = media?.artistName
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
