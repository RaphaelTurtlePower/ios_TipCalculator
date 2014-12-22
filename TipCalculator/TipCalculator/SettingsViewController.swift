//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by cmamuad on 12/21/14.
//  Copyright (c) 2014 cmamuad. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  
    @IBOutlet weak var DefaultPercentageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("viewDidLoad initiated for SettingsViewController")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSaveClicked(sender: AnyObject) {
    }
    
}

