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

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        let currentTipPercentage = setTipControl.titleForSegmentAtIndex(setTipControl.selectedSegmentIndex)!
        let endIndex = currentTipPercentage.endIndex.advancedBy(-1)
        
        setTipStepper.value = Double(currentTipPercentage.substringToIndex(endIndex))!
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
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
        let currentTipPercentage = setTipControl.titleForSegmentAtIndex(setTipControl.selectedSegmentIndex)!
        let endIndex = currentTipPercentage.endIndex.advancedBy(-1)
        
        setTipStepper.value = Double(currentTipPercentage.substringToIndex(endIndex))!
        
    }
    @IBAction func onStepperChanged(sender: UIStepper) {
        
        let newTipPercentage = String(Int(sender.value)) + "%"
        let currentIndex = setTipControl.selectedSegmentIndex
        
        setTipControl.setTitle(newTipPercentage, forSegmentAtIndex: currentIndex)
        
        
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
