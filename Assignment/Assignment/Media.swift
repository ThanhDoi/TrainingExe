//
//  Media.swift
//  Assignment
//
//  Created by Thanh Doi on 4/10/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import Foundation

class Media {
    var trackName: String?
    var artistName: String?
    var imageData: Data?
    
    init(trackName: String, artistName: String, imageURL: String) {
        self.trackName = trackName
        self.artistName = artistName
        let url = URL(string: imageURL)
        self.imageData = try? Data(contentsOf: url!)
    }
    
}
