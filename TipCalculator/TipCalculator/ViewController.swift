//
//  ViewController.swift
//  TipCalculator
//
//  Created by cmamuad on 12/20/14.
//  Copyright (c) 2014 cmamuad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TipAmountLabel: UILabel!
    @IBOutlet weak var BillAmount: UITextField!
    @IBOutlet weak var TotalAmountLabel: UILabel!
    @IBOutlet weak var TipPercentageSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TipAmountLabel.text = "0.00"
        TotalAmountLabel.text = "0.00"
       
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.Plain, target: self, action: "onSettingsClicked"), animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func onSettingsClicked(){
        println("On Settings Clicked triggered.")
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
            view.endEditing(true)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.15, 0.18, 0.20]
        var tipPercentage = tipPercentages[TipPercentageSegment.selectedSegmentIndex]
        
        println("Editing the BillAmount")
        var billAmount = (BillAmount.text as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        TipAmountLabel.text = String(format: "$%.2f", tip)
        TotalAmountLabel.text = String(format: "$%.2f", total)
    }

}

