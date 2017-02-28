//
//  MainViewController.swift
//  TrainingExe3
//
//  Created by Hung Nguyen on 2/28/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        self.navigationItem.title = "Main ViewController"
        
        let firstButton = UIButton(frame: CGRect(origin: CGPoint(x: view.center.x - 50, y: view.center.y), size: CGSize(width: 100, height: 20)))
        firstButton.setTitle("First", for: .normal)
        firstButton.addTarget(self, action: #selector(MainViewController.pushFirst), for: .touchUpInside)
        view.addSubview(firstButton)
        
        let secondButton = UIButton(frame: CGRect(origin: CGPoint(x: view.center.x - 50, y: view.center.y+40), size: CGSize(width: 100, height: 20)))
        secondButton.setTitle("Second", for: .normal)
        secondButton.addTarget(self, action: #selector(MainViewController.pushSecond), for: .touchUpInside)
        view.addSubview(secondButton)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushFirst() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let firstViewController = storyBoard.instantiateViewController(withIdentifier: "firstViewController")
        self.navigationController?.pushViewController(firstViewController, animated: true)
    }
    
    func pushSecond() {
        let secondViewController = SecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
