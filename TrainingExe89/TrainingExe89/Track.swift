//
//  Track.swift
//  TrainingExe89
//
//  Created by Thanh Doi on 3/29/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import Foundation

class Track {
    var name: String?
    var artist: String?
    var previewUrl: String?
    
    init(name: String?, artist: String?, previewUrl: String?) {
        self.name = name
        self.artist = artist
        self.previewUrl = previewUrl
    }
}
