//
//  AVResult.swift
//  TrainingExe4
//
//  Created by Thanh Doi on 3/8/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class AVResult {
    
    // MARK: Properties
    var captureDate: Date
    var avValue: Float
    var loviValue: Int
    
    // MARK: Initialization
    init(captureDate: Date, avValue: Float, loviValue: Int) {
        self.captureDate = captureDate
        self.avValue = avValue
        self.loviValue = loviValue
    }
}
