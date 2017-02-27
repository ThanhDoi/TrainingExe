//
//  ViewController.swift
//  TrainingExe2
//
//  Created by Thanh Doi on 2/27/17.
//  Copyright © 2017 Thanh Doi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: Properties
    @IBOutlet weak var familyNameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var furiganaFamilyNameTextField: UITextField!
    @IBOutlet weak var furiganaNameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var tel01TextField: UITextField!
    @IBOutlet weak var tel02TextField: UITextField!
    @IBOutlet weak var tel03TextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var genderButton: UISegmentedControl!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: check mail function
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // MARK: Actions
    @IBAction func register(_ sender: UIButton) {
        if ((familyNameTextField.text?.isEmpty)! || (nameTextField.text?.isEmpty)! || (furiganaFamilyNameTextField.text?.isEmpty)! || (
            furiganaNameTextField.text?.isEmpty)! || (mailTextField.text?.isEmpty)! || (birthdayTextField.text?.isEmpty)! || (tel01TextField.text?.isEmpty)! || (tel02TextField.text?.isEmpty)! || (tel03TextField.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Alert", message: "You must fill all field", preferredStyle: UIAlertControllerStyle.alert)
            // Alert
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let mail = mailTextField.text!
            if (!isValidEmail(testStr: mail)) {
                let alert = UIAlertController(title: "Alert", message: "You must enter real email!", preferredStyle: UIAlertControllerStyle.alert)
                // Alert
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Alert", message: "Successful", preferredStyle: UIAlertControllerStyle.alert)
                // Alert
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

