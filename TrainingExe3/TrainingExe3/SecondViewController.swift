//
//  ViewController.swift
//  Test
//
//  Created by Thanh Doi on 2/28/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var grayView: UIView!
    var blueView: UIView!
    var redView: UIView!
    
    var label: UILabel!
    
    func initViews() -> Void {
        let grayView = UIView()
        grayView.backgroundColor = UIColor.gray
        self.view.addSubview(grayView)
        
        let leadingGray = NSLayoutConstraint(item: grayView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 10.0)
        
        let trailingGray = NSLayoutConstraint(item: grayView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -10.0)
        
        let topGray = NSLayoutConstraint(item: grayView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 75.0)
        
        let heightGray = NSLayoutConstraint(item: grayView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        
        NSLayoutConstraint.activate([leadingGray, trailingGray, topGray, heightGray])
        
        grayView.translatesAutoresizingMaskIntoConstraints = false
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        self.view.addSubview(blueView)
        
        let trailingBlue = NSLayoutConstraint(item: blueView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -10.0)
        
        let topBlue = NSLayoutConstraint(item: blueView, attribute: .top, relatedBy: .equal, toItem: grayView, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        
        let heightBlue = NSLayoutConstraint(item: blueView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        
        let widthBlue = NSLayoutConstraint(item: blueView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        
        NSLayoutConstraint.activate([trailingBlue, topBlue, heightBlue, widthBlue])
        blueView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "I have some longer text here that I want to wrap onto multiple lines."
        label.numberOfLines = 0
        self.view.addSubview(label)
        
        let leadingLabel = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 10.0)
        
        let trailingLabel = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: blueView, attribute: .leading, multiplier: 1.0, constant: 10.0)
        
        let topLabel = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: grayView, attribute: .bottom, multiplier: 1.0, constant: 10)
        
        NSLayoutConstraint.activate([leadingLabel, trailingLabel, topLabel])
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        self.view.addSubview(redView)
        
        let botRed  = NSLayoutConstraint(item: redView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -10.0)
        
        let heightRed = NSLayoutConstraint(item: redView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        
        let widthRed = NSLayoutConstraint(item: redView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        
        let horizontalRed = NSLayoutConstraint(item: redView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([botRed, heightRed, widthRed, horizontalRed])
        redView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        initViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

