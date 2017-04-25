//
//  NetworkManager.swift
//  Assignment
//
//  Created by Thanh Doi on 4/10/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
    }
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var searchResults = [Media]()
    
    var dataTask: URLSessionDataTask?
    
    func updateSearchResults(_ data: Data?)
    {
        var name: String?
        searchResults.removeAll()
        do {
            if let data = data, let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String:AnyObject] {
                
                // Get the results array
                if let array: AnyObject = response["results"] {
                    for trackDictionary in array as! [AnyObject] {
                        if let trackDictionary = trackDictionary as? [String: AnyObject] {
                            // Parse the search result
                            let type = trackDictionary["wrapperType"] as? String
                            if type == "audiobook" {
                                name = trackDictionary["collectionName"] as? String
                            } else {
                                name = trackDictionary["trackName"] as? String
                            }
                            let artist = trackDictionary["artistName"] as? String
                            let imageURL = trackDictionary["artworkUrl100"] as? String
                            searchResults.append(Media(trackName: name!, artistName: artist!, imageURL: imageURL!))
                        } else {
                            print("Not a dictionary")
                        }
                    }
                } else {
                    print("Result key not found in dictionary")
                }
            } else {
                print("JSON error")
            }
        } catch let error {
            print("Error parsing result: \(error.localizedDescription)")
        }
    }
    
    func updateSearchResultsToBlock(_ url: URL, completion: @escaping ((_ searchResults: [Media]) -> Void)) {
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        dataTask = defaultSession.dataTask(with: url) {
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.updateSearchResults(data)
                    completion(self.searchResults)
                }
            }
        }
        dataTask?.resume()
    }
}
