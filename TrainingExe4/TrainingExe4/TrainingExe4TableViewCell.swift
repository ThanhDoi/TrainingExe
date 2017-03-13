//
//  TrainingExe4TableViewCell.swift
//  TrainingExe4
//
//  Created by Thanh Doi on 3/8/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class TrainingExe4TableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIView!
    @IBOutlet weak var captureDateLabel: UILabel!
    @IBOutlet weak var avValueLabel: UILabel!
    @IBOutlet weak var loviValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
