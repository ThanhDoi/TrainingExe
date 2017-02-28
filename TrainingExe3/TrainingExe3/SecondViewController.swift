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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        grayView = UIView()
        grayView.backgroundColor = UIColor.gray
        grayView.translatesAutoresizingMaskIntoConstraints = false
        blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        blueView.translatesAutoresizingMaskIntoConstraints = false
        redView = UIView()
        redView.backgroundColor = UIColor.red
        redView.translatesAutoresizingMaskIntoConstraints = false;
        label = UILabel()
        label.text = "I have some longer text here that I want to wrap onto multiple lines."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view.addSubview(grayView)
        self.view.addSubview(blueView)
        self.view.addSubview(redView)
        self.view.addSubview(label)
        let views = ["gray": grayView, "blue": blueView, "red": redView, "label": label, "view": view]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let grayHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[gray]-10-|", options: [], metrics: nil, views: views)
        allConstraints += grayHorizontalConstraints
        
        let grayVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[gray(100)]", options: [], metrics: nil, views: views)
        allConstraints += grayVerticalConstraints
        
        let labelVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[gray]-10-[label]", options: [], metrics: nil, views: views)
        allConstraints += labelVerticalConstraints
        
        let blueVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[gray]-10-[blue(100)]", options: [], metrics: nil, views: views)
        allConstraints += blueVerticalConstraints
        
        let labelAndBlueHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[label]-10-[blue(100)]-10-|", options: [.alignAllCenterY], metrics: nil, views: views)
        allConstraints += labelAndBlueHorizontalConstraints
        
        let redVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-(<=0)-[red(100)]-10-|", options: [.alignAllCenterX], metrics: nil, views: views)
        allConstraints += redVerticalConstraints
        
        let redHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[red(100)]", options: [.alignAllCenterY], metrics: nil, views: views)
        allConstraints += redHorizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

