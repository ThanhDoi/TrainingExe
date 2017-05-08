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
    @IBOutlet weak var pageView: UIView!
    
    var pageViewController: UIPageViewController?
    var orderedPageViewController = [ResultTableViewController]()
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
            self.pageView.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().draggableBorderWidth = self.view.frame.size.width / 4
            self.revealViewController().rearViewRevealWidth = 100
        }
        // MARK: Select tab
        updateCurrentMediaType()
        initOrderedPageViewController()
        createPageViewController()
        // MARK: getResultFromLeftMenu
        NotificationCenter.default.addObserver(self, selector: #selector(getResultFromLeftMenu(_:)), name: NSNotification.Name(rawValue: didChosenLeftMenu), object: nil)
    }
    
    func initOrderedPageViewController() {
        for _ in 1...5 {
            self.orderedPageViewController.append(self.newResultTableViewController())
        }
    }
    
    func newResultTableViewController() -> ResultTableViewController {
        return self.storyboard?.instantiateViewController(withIdentifier: "ResultTableViewController") as! ResultTableViewController
    }
    
    func createPageViewController() {
        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
        pageController.dataSource = self
        if !searchBar.text!.isEmpty {
            let index = currentSelectedType.index(of: true)
            let firstController = orderedPageViewController[index!]
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: .forward, animated: true, completion: nil)
        }
        pageViewController = pageController
        addChildViewController(pageViewController!)
        pageViewController?.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.pageView.addSubview(pageViewController!.view)
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
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            let index = self.currentSelectedType.index(of: true)
            self.orderedPageViewController[index!].searchResults = self.searchResults
            self.orderedPageViewController[index!].tableView.reloadData()
            let firstController = self.orderedPageViewController[index!]
            let startingViewControllers = [firstController]
            self.pageViewController?.setViewControllers(startingViewControllers, direction: .forward, animated: true, completion: nil)
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

// MARK: - UIPageViewControllerDataSource
extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = currentSelectedType.index(of: true)
        currentSelectedType[index!] = false
        index = index! - 1
        if index == -1 {
            index = 4
        }
        currentSelectedType[index!] = true
        currentMediaType = items[index!]
        updateCurrentMediaType()
        DispatchQueue.main.async {
            self.searchBarSearchButtonClicked(self.searchBar)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = currentSelectedType.index(of: true)
        currentSelectedType[index!] = false
        index = index! + 1
        if index == 5 {
            index = 0
        }
        currentSelectedType[index!] = true
        currentMediaType = items[index!]
        updateCurrentMediaType()
        DispatchQueue.main.async {
            self.searchBarSearchButtonClicked(self.searchBar)
        }
        return nil
    }
}
