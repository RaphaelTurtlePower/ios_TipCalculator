//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by cmamuad on 12/21/14.
//  Copyright (c) 2014 cmamuad. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var LowTextField: UITextField!
    @IBOutlet weak var MidTextField: UITextField!
    @IBOutlet weak var HighTextField: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var percentages : [Int] = SettingsViewController.getDefaultPercentages()
        LowTextField.text = String(percentages[0])
        MidTextField.text = String(percentages[1])
        HighTextField.text = String(percentages[2])
        
    }
    
    @IBAction func lightThemeClicked(sender: AnyObject) {
        saveDefaultTheme("light")
        SettingsViewController.setTheme(self.view, theme: "light")
    }
    @IBAction func darkThemeClicked(sender: AnyObject) {
         saveDefaultTheme("dark")
        SettingsViewController.setTheme(self.view, theme: "dark")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSaveClicked(sender: AnyObject) {
        var low :Int = LowTextField.text.toInt()!
        var mid : Int = MidTextField.text.toInt()!
        var high :Int = HighTextField.text.toInt()!
        
        saveDefaultPercentages(low, mid:mid, high:high)
        var animate : Bool = true;
        navigationController?.popViewControllerAnimated(animate)
    }
    
    func saveDefaultTheme(color:(String)){
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(color, forKey: "theme")
        defaults.synchronize()
    }
    
    class func getDefaultTheme() -> String {
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var theme: String! = defaults.stringForKey("theme")
        if (theme == nil){
            theme = "light"
        }
        return theme;
    }
    
    func saveDefaultPercentages(low:(Int), mid:(Int), high:(Int)){
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(low, forKey: "low")
        defaults.setInteger(mid, forKey: "mid")
        defaults.setInteger(high, forKey: "high")
        defaults.synchronize()
    }
    
    class func getDefaultPercentages() -> [Int]{
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var low  : Int = defaults.integerForKey("low")
        var mid  : Int = defaults.integerForKey("mid")
        var high : Int = defaults.integerForKey("high")
        var percentages : [Int] = [15,18,20]
        
        if(low > 0 && mid > 0 && high > 0){
            //no problems with saved info
            percentages = [low, mid, high]
        }
        return percentages
    }
    
    override func viewWillAppear(animated: Bool) {
        var theme: String = SettingsViewController.getDefaultTheme()
        
        SettingsViewController.setTheme(self.view, theme: theme)
    }
    
    class func setTheme(rootView:UIView, theme: (String)){
        SettingsViewController.setViewStyle(rootView, theme: theme)
        SettingsViewController.setThemeRecursively(rootView, theme: theme)
    }
    
    class func setThemeRecursively(rootView:UIView, theme: (String)){
        if let textField = rootView as? UITextField {
            setTextFieldStyle(textField, theme: theme)
        }else if let lb = rootView as? UILabel {
            setLabelStyle(lb, theme: theme)
        }
        
        for v in rootView.subviews as [UIView] {
            SettingsViewController.setThemeRecursively(v, theme: theme)
        }

    }
    
    class func setViewStyle(view:UIView, theme:String){
        if(theme == "dark"){
            view.backgroundColor = UIColor.blackColor()
        }else{
            view.backgroundColor = UIColor.whiteColor()
        }
    }
    
    class func setLabelStyle(label:UILabel, theme:String){
        if(theme == "dark"){
           label.textColor = UIColor.whiteColor()
        }else{
            label.textColor = UIColor.blackColor()
        }
    }
    
    class func setTextFieldStyle(control:UITextField, theme:String){
        if(theme == "dark"){
            control.textColor = UIColor.whiteColor()
            control.backgroundColor = UIColor(netHex: 0x006600)
            
        }else{
            control.textColor = UIColor.blackColor()
            control.backgroundColor = UIColor(netHex: 0x33FF33)
        }
    }
 

    
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

