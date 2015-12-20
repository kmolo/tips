//
//  ViewController.swift
//  tips
//
//  Created by mny on 11/23/15.
//  Copyright © 2015 ccsf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var tipPercentages = [0.18, 0.20, 0.22]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"

        let now = NSDate()
        let before = NSUserDefaults.standardUserDefaults().objectForKey("savedTime") as? NSDate
        
        if (before != nil && now.timeIntervalSinceDate(before!) < 600){
            billField.text = NSUserDefaults.standardUserDefaults().stringForKey("savedAmt")
        }
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        billField.becomeFirstResponder()
        
        refreshTipPercentages()
        calculate()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "savedTime")
        NSUserDefaults.standardUserDefaults().setObject(billField.text, forKey: "savedAmt")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        calculate()
        
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func refreshTipPercentages(){
        var tipLow = NSUserDefaults.standardUserDefaults().stringForKey("tip_low")!
        var tipMid = NSUserDefaults.standardUserDefaults().stringForKey("tip_mid")!
        var tipHigh = NSUserDefaults.standardUserDefaults().stringForKey("tip_high")!
        
        print("TVC: tip percents without symbol before checking")
        print(tipLow)
        print(tipMid)
        print(tipHigh)
        
        if (tipLow.isEmpty) { tipLow = "18.0" }
        if (tipMid.isEmpty) { tipMid = "20.0" }
        if (tipHigh.isEmpty) { tipHigh = "22.0" }

        print("TVC: tip percents without symbol after checking")
        print(tipLow)
        print(tipMid)
        print(tipHigh)
        
        tipPercentages[0] = NSString(string: tipLow).doubleValue / 100.0
        tipPercentages[1] = NSString(string: tipMid).doubleValue / 100.0
        tipPercentages[2] = NSString(string: tipHigh).doubleValue / 100.0
        
        tipLow += "%"
        tipMid += "%"
        tipHigh += "%"
        
        print("TVC: tip percents with symbol")
        print(tipLow)
        print(tipMid)
        print(tipHigh)
        
        tipControl.setTitle(tipLow, forSegmentAtIndex: 0)
        tipControl.setTitle(tipMid, forSegmentAtIndex: 1)
        tipControl.setTitle(tipHigh, forSegmentAtIndex: 2)
        
    }
    
    func calculate() {
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()

        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)!
        totalLabel.text = currencyFormatter.stringFromNumber(total)!
        
    }
    
}
