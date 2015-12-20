//
//  SettingsViewController.swift
//  tips
//
//  Created by mny on 12/5/15.
//  Copyright © 2015 ccsf. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var setTipControl: UISegmentedControl!
    @IBOutlet weak var setTipStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        refreshTipPercentages()
        selectSegment()
        setStepperValue()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
        saveValues()

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSetTipControlChanged() {
        setStepperValue()
        
    }
    
    @IBAction func onStepperChanged(sender: UIStepper) {
        let newTipPercentage = String(Int(sender.value)) + "%"
        let currentIndex = setTipControl.selectedSegmentIndex
        
        setTipControl.setTitle(newTipPercentage, forSegmentAtIndex: currentIndex)
        
    }
    
    func setStepperValue() {
        let currentTipPercentage = setTipControl.titleForSegmentAtIndex(setTipControl.selectedSegmentIndex)!
        let endIndex = currentTipPercentage.endIndex.advancedBy(-1)
        
        setTipStepper.value = Double(currentTipPercentage.substringToIndex(endIndex))!
    }
    
    func saveValues() {
        let tip_low_with_symbol = setTipControl.titleForSegmentAtIndex(0)!
        let tip_mid_with_symbol = setTipControl.titleForSegmentAtIndex(1)!
        let tip_high_with_symbol = setTipControl.titleForSegmentAtIndex(2)!
        
//        print("SVC tip percentages with %")
//        print(tip_low_with_symbol)
//        print(tip_mid_with_symbol)
//        print(tip_high_with_symbol)
        
        let tip_low = tip_low_with_symbol.substringToIndex(tip_low_with_symbol.endIndex.advancedBy(-1))
        let tip_mid = tip_mid_with_symbol.substringToIndex(tip_mid_with_symbol.endIndex.advancedBy(-1))
        let tip_high = tip_high_with_symbol.substringToIndex(tip_high_with_symbol.endIndex.advancedBy(-1))
        
//        print("SVC tip percentages without %")
//        print(tip_low)
//        print(tip_mid)
//        print(tip_high)
        
        NSUserDefaults.standardUserDefaults().setObject(String(tip_low), forKey: "tip_low")
        NSUserDefaults.standardUserDefaults().setObject(String(tip_mid), forKey: "tip_mid")
        NSUserDefaults.standardUserDefaults().setObject(String(tip_high), forKey: "tip_high")
        NSUserDefaults.standardUserDefaults().setObject(setTipControl.selectedSegmentIndex, forKey: "selected_segment")
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func refreshTipPercentages(){
        var tipLow = NSUserDefaults.standardUserDefaults().stringForKey("tip_low")
        var tipMid = NSUserDefaults.standardUserDefaults().stringForKey("tip_mid")
        var tipHigh = NSUserDefaults.standardUserDefaults().stringForKey("tip_high")
        
//        print("TVC: tip percents without symbol before checking")
//        print(tipLow)
//        print(tipMid)
//        print(tipHigh)
        
        if (tipLow == nil ) { tipLow = "18.0" }
        if (tipMid == nil ) { tipMid = "20.0" }
        if (tipHigh == nil ) { tipHigh = "22.0" }
        
//        print("TVC: tip percents without symbol after checking")
//        print(tipLow)
//        print(tipMid)
//        print(tipHigh)
        
        tipLow! += "%"
        tipMid! += "%"
        tipHigh! += "%"
        
//        print("TVC: tip percents with symbol")
//        print(tipLow)
//        print(tipMid)
//        print(tipHigh)
        
        setTipControl.setTitle(tipLow, forSegmentAtIndex: 0)
        setTipControl.setTitle(tipMid, forSegmentAtIndex: 1)
        setTipControl.setTitle(tipHigh, forSegmentAtIndex: 2)
        
    }
    
    func selectSegment() {
        var selectedSegment = NSUserDefaults.standardUserDefaults().stringForKey("selected_segment")
        
        if (selectedSegment == nil) { selectedSegment = "0" }
        
        setTipControl.selectedSegmentIndex = Int(selectedSegment!)!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
