//
//  NetworkManager.swift
//  TrainingExe89
//
//  Created by Thanh Doi on 3/29/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate: class {
    func didUpdateSearchResult(searchResults: [Track])
}

let didUpdateSearchResult = "didUpdateSearchResult"

class NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?
    
    static let shared = NetworkManager()
    
    private init() {
    }
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var searchResults = [Track]()
    
    var dataTask: URLSessionDataTask?
    
    func updateSearchResultsFromUrl(_ url: URL) {
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
                }
            }
        }
        dataTask?.resume()
    }
    
    func updateSearchResults(_ data: Data?)
    {
        searchResults.removeAll()
        do {
            if let data = data, let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String:AnyObject] {
                
                // Get the results array
                if let array: AnyObject = response["results"] {
                    for trackDictionary in array as! [AnyObject] {
                        if let trackDictionary = trackDictionary as? [String: AnyObject], let previewUrl = trackDictionary["previewUrl"] as? String {
                            // Parse the search result
                            let name = trackDictionary["trackName"] as? String
                            let artist = trackDictionary["artistName"] as? String
                            searchResults.append(Track(name: name, artist: artist, previewUrl: previewUrl))
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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: didUpdateSearchResult), object: searchResults)
            delegate?.didUpdateSearchResult(searchResults: searchResults)
        } catch let error {
            print("Error parsing result: \(error.localizedDescription)")
        }
    }
    
    func updateSearchResultsToBlock(_ url: URL, completion: @escaping ((_ searchResults: [Track]) -> Void)) {
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
