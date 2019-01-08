//
//  OptionsController.swift
//  TipCalculator
//
//  Created by Chase Carnaroli on 1/7/19.
//  Copyright © 2019 Chase Carnaroli. All rights reserved.
//

import UIKit

class OptionsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var main: ViewController?
    
    @IBOutlet weak var firstTip: UITextField!
    @IBOutlet weak var secondTip: UITextField!
    @IBOutlet weak var thirdTip: UITextField!
    
    var tipLabels: [UITextField] = []
    
    @IBOutlet weak var currencyInput: UILabel!
    @IBOutlet weak var currencySelector: UIPickerView!
    
    var currencies = ["$", "€", "£"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tip Percents setup
        tipLabels = [firstTip, secondTip, thirdTip]
        for i in 0...2{
            tipLabels[i].text = String((main?.tipPercents[i])!*100)
        }

        
        // Currency Picker setup
        // Format currencyInput to look like a text field
        currencyInput.layer.cornerRadius = 5
        currencyInput.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        currencyInput.layer.borderWidth = 0.5
        currencyInput.clipsToBounds = true
        
        currencyInput.text = main?.billField.placeholder
        
        self.currencySelector.dataSource = self
        self.currencySelector.delegate = self
        
        currencyInput.text = main?.currency
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateTipPercents() {
        for i in 0...2{
            main?.tipPercents[i] = (Double(tipLabels[i].text!) ?? 0)/100
            main?.tipPercentSelector.setTitle(tipLabels[i].text! + "%", forSegmentAt: i)
        }
        main?.calculateTip(self)
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(false)
    }
    
    
    // UIPicker Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // Number of columns
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Number of rows
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        // Return a string from the array for this row.
        view.endEditing(false)
        let selectedCurrency = currencies[row]
        currencyInput.text = selectedCurrency
        main?.currency = selectedCurrency
        main?.updateCurrency(symbol: selectedCurrency)
        return selectedCurrency
    }
}
