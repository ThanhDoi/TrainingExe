//
//  TrainingExe7TableViewCell.swift
//  TrainingExe7
//
//  Created by Thanh Doi on 3/20/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class TrainingExe7TableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var thumbnailImageView: UIImageView!
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
