//
//  ViewController.swift
//  TrainingExe6
//
//  Created by Thanh Doi on 3/14/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    @IBOutlet weak var imageView10: UIImageView!
    @IBOutlet weak var imageView11: UIImageView!
    @IBOutlet weak var imageView12: UIImageView!
    
    // imageView: mang cac imageView
    var imageView: [UIImageView] = []
    var imageName: [String] = ["Elekid", "Latias", "Latios", "Lugia", "Mewtwo", "Zapdos"]
    
    // imageArrange: mang luu anh cua ca o hien tai
    var imageArrange = Array(repeating: "", count: 12)
    
    var imageIsShowing: [UIImageView] = []
    
    private func initImageView() -> Void {
        imageView += [imageView1, imageView2, imageView3, imageView4, imageView5, imageView6, imageView7, imageView8, imageView9, imageView10, imageView11, imageView12]
        
        // Make random image
        var random: Int!
        for name in imageName {
            repeat {
                random = Int(arc4random_uniform(6))
            } while imageArrange[random] != ""
            imageArrange[random] = name
            repeat {
                random = Int(arc4random_uniform(6)) + 6
            } while imageArrange[random] != ""
            imageArrange[random] = name
        }
    }
    @IBAction func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        let view = sender.view as! UIImageView
        
        imageIsShowing.append(view)
        for image in imageIsShowing {
            image.image = UIImage(named: imageArrange[imageView.index(of: image)!])
        }
        if imageIsShowing.count == 2 {
            for imgView in imageView {
                imgView.isUserInteractionEnabled = false
            }
        }
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.checkImage), userInfo: nil, repeats: false)
    }
    
    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        let view = sender.view as! UIImageView
        
        imageIsShowing.append(view)
        for image in imageIsShowing {
            image.image = UIImage(named: imageArrange[imageView.index(of: image)!])
        }
        if imageIsShowing.count == 2 {
            for imgView in imageView {
                imgView.isUserInteractionEnabled = false
            }
        }
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.checkImage), userInfo: nil, repeats: false)
    }
    
    func checkImage() -> Void {
        if imageIsShowing.count == 2 {
            if imageIsShowing[0] == imageIsShowing[1] {
                imageIsShowing[0].image = UIImage(named: "Default")
                imageIsShowing.removeAll()
            } else {
                let image1 = imageArrange[imageView.index(of: imageIsShowing[0])!]
                let image2 = imageArrange[imageView.index(of: imageIsShowing[1])!]
                if image1 == image2 {
                    for image in imageIsShowing {
                        image.isHidden = true
                    }
                }
                for image in imageIsShowing {
                    image.image = UIImage(named: "Default")
                }
                imageIsShowing.removeAll()
            }
        }
        
        for image in imageView {
            image.isUserInteractionEnabled = true
        }
        
        var isEnd: Bool = true
        for image in imageView {
            if image.isHidden == false {
                isEnd = false
            }
        }
        if isEnd == true {
            let alert = UIAlertController(title: "Finish", message: "Good job! You are finish the game!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initImageView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

