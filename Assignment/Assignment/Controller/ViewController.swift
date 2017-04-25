//
//  ViewController.swift
//  Assignment
//
//  Created by Thanh Doi on 4/3/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    var currentSelectedType = [Bool](repeating: false, count: 5)
    var currentMediaType: String?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchResults = [Media]()
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(self.dismissKeyboard))
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().draggableBorderWidth = self.view.frame.size.width / 4
            self.revealViewController().rearViewRevealWidth = 100
        }
        
        // MARK: Select tab
        updateCurrentMediaType()
        // MARK: getResultFromLeftMenu
        NotificationCenter.default.addObserver(self, selector: #selector(getResultFromLeftMenu(_:)), name: NSNotification.Name(rawValue: didChosenLeftMenu), object: nil)
    }
    
    func updateCurrentMediaType() {
        if currentMediaType == nil {
            currentSelectedType[0] = true
            currentMediaType = items[0]
        } else {
            for i in 0...4 {
                if items[i] == currentMediaType {
                    currentSelectedType[i] = true
                } else {
                    currentSelectedType[i] = false
                }
            }
        }
        collectionView.reloadData()
        for i in 0...4 {
            if currentSelectedType[i] == true {
                let indexPath = IndexPath(row: i, section: 0)
                collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUpdateSearchResult(_ searchResults: [Media]) {
        self.searchResults = searchResults
        DispatchQueue.main.async {
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.tableView.setContentOffset(CGPoint.zero, animated: false)
        }
    }
    
    func getResultFromLeftMenu(_ notification: Notification) {
        let result = notification.object as! String
        self.currentMediaType = result
        updateCurrentMediaType()
        searchBarSearchButtonClicked(self.searchBar)
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selected = searchResults[indexPath.row]
            let destionation = segue.destination as! CellDeltailViewController
            destionation.media = selected
        }
    }
    
    
    // MARK: Gesture Handle
    func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        var index = currentSelectedType.index(of: true)
        if sender.direction == UISwipeGestureRecognizerDirection.right {
            currentSelectedType[index!] = false
            index = index! - 1
            if index == -1 {
                index = 4
            }
            currentSelectedType[index!] = true
            currentMediaType = items[index!]
        }
        if sender.direction == UISwipeGestureRecognizerDirection.left {
            currentSelectedType[index!] = false
            index = index! + 1
            if index == 5 {
                index = 0
            }
            currentSelectedType[index!] = true
            currentMediaType = items[index!]
        }
        updateCurrentMediaType()
        searchBarSearchButtonClicked(self.searchBar)
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath) as! TabCollectionViewCell
        cell.label.text = items[indexPath.row]
        if currentSelectedType[indexPath.row] {
            cell.backgroundColor = UIColor.green
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentMediaType = items[indexPath.row]
        updateCurrentMediaType()
        if !self.searchBar.text!.isEmpty {
            searchBarSearchButtonClicked(self.searchBar)
        }
    }
}

// MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        if !searchBar.text!.isEmpty {
            let expectedCharSet = CharacterSet.urlQueryAllowed
            let searchTerm = searchBar.text!.addingPercentEncoding(withAllowedCharacters: expectedCharSet)!
            let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&media=\(currentMediaType!)")
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            NetworkManager.shared.updateSearchResultsToBlock(url!, completion: {searchResults in
                self.getUpdateSearchResult(searchResults)})
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.removeGestureRecognizer(tapRecognizer)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ResultCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchResultCell
        
        let media = searchResults[indexPath.row]
        
        cell.trackNameLabel.text = media.trackName
        cell.artistNameLabel.text = media.artistName
        cell.thumbnailImage.image = UIImage(data: media.imageData!)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRightGesture.direction = UISwipeGestureRecognizerDirection.right
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.left
        
        cell.addGestureRecognizer(swipeRightGesture)
        cell.addGestureRecognizer(swipeLeftGesture)
        
        return cell
    }
}
