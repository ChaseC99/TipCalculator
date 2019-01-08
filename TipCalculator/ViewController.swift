//
//  ViewController.swift
//  TipCalculator
//
//  Created by Chase Carnaroli on 12/21/18.
//  Copyright © 2018 Chase Carnaroli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipPercentSelector: UISegmentedControl!
    
    @IBOutlet weak var optionsBarButtonItem: UIBarButtonItem!
    
    var tipPercents = [0.18, 0.2, 0.25]
    var currency = "$"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        optionsBarButtonItem.tintColor = UIColor.gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(false)
    }
    
    func updateCurrency(symbol: String)
    {
        // Update billField
        var billText = billField.text!
        billText.removeFirst()
        billField.text = currency + billText
        
        // Update tipLabel
        var tipText = tipLabel.text!
        tipText.removeFirst()
        tipLabel.text = currency + tipText
        
        // Update totalLabel
        var totalText = totalLabel.text!
        totalText.removeFirst()
        totalLabel.text = currency + totalText
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Add $ to front of bill amount
        if(!billField.text!.starts(with: currency)){
            billField.text = currency + billField.text!
        }
        
        // Get the inputted bill value
        var billText = billField.text!
        billText.removeFirst()
        let bill = Double(billText) ?? 0
        
        // Calculate tip
        let tip = bill * tipPercents[tipPercentSelector.selectedSegmentIndex]
        let total = bill + tip
        
        // Update Tip and Total Labels
        tipLabel.text = currency + String(format: "%.2f", tip)
        totalLabel.text = currency + String(format: "%.2f", total)
    }
    
    // Mark: Segue
    //      This code sends the OptionsController information about itself
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let optionsController: OptionsController = segue.destination as! OptionsController
        optionsController.main = self
    }
}

