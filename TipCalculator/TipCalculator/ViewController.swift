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
    var tipPercentages : [Int]!;
    @IBOutlet weak var peopleSlider: UISlider!
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TipAmountLabel.text = "0.00"
        TotalAmountLabel.text = "0.00"
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.Plain, target: self, action: "onSettingsClicked"), animated: true)
    }
    
    //slider control
    @IBAction func onSliderChanged(sender: AnyObject) {
        view.endEditing(true)
        peopleCountLabel.text = String(Int(peopleSlider.value))
        calculateValues()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
            view.endEditing(true)
    }
    
    //tip selector control
    @IBAction func onTipSelected(sender: AnyObject) {
        view.endEditing(true)
        calculateValues()
    }
    
    //on keyboard press
    @IBAction func onEditingChanged(sender: AnyObject) {
        calculateValues()
    }
    
    override func viewWillAppear(animated: Bool) {
        println("View Will Appear called")
        resetTipPercentages()
        calculateValues()
        var theme: String = SettingsViewController.getDefaultTheme()
        SettingsViewController.setViewStyle(self.view, theme: theme)
        SettingsViewController.setTheme(self.view, theme: theme)
    }
    
    override func viewDidAppear(animated: Bool) {
        println("View Did Appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        println("View Will Disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        println("View did Disappear")
    }

    
    
    
    func resetTipPercentages(){
        TipPercentageSegment.removeAllSegments()
        tipPercentages = SettingsViewController.getDefaultPercentages()
        
        for index in 0...tipPercentages.count-1{
            var title = String(tipPercentages[index]) + "%"
            TipPercentageSegment.insertSegmentWithTitle(title, atIndex: index, animated: true)
        }
        TipPercentageSegment.selectedSegmentIndex = 0
        
        
    }
    
    func onSettingsClicked(){
        println("On Settings Clicked triggered.")
        var viewController : UIViewController = self.navigationController?.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as UIViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func calculateValues(){
        var tipPercentage : Double = Double(tipPercentages[TipPercentageSegment.selectedSegmentIndex]) / Double(100)

        var numberOfPeople = Int(peopleSlider.value)
        var billAmount = (BillAmount.text as NSString).doubleValue
        var tip = (billAmount * tipPercentage) / Double(numberOfPeople)
        var total = (billAmount + tip) / Double(numberOfPeople)
        TipAmountLabel.text = String(format: "$%.2f", tip)
        TotalAmountLabel.text = String(format: "$%.2f", total)
    }

    
}

