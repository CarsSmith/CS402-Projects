//
//  ViewController.swift
//  BMICalculator
//
//  Created by user159305 on 9/9/19.
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var unitSystemSwitch: UISwitch!
    
    @IBOutlet weak var unitSwitchLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calculationButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var historyButton: UIButton!
    
    @IBOutlet weak var result2Label: UILabel!
    //This boolean value depicts the type of system that is being used. False meaning metric and true being Standard
    var unitSystemBoolean:Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func SwitchFlipped(_ sender: Any) { //Change from metric computation to standard or vise-versa
        
        if unitSystemSwitch.isOn {
            unitSwitchLabel.text = "Standard"
            heightLabel.text = "Height (in)"
            weightLabel.text = "Weight (lb)"
            heightTextField.text = ""
            weightTextField.text = ""
            unitSystemBoolean = true
        } else {
            unitSwitchLabel.text = "Metric"
            heightLabel.text = "Height (cm)"
            weightLabel.text = "Weight (kg)"
            heightTextField.text = ""
            weightTextField.text = ""
            unitSystemBoolean = false
        }
    }
    
    @IBAction func CalculateButtonPressed(_ sender: Any) {
        
        let stringHeight = heightTextField.text
        let stringWeight = weightTextField.text
        
        heightTextField.text = ""
        weightTextField.text = ""
        
        let height:Int = Int(stringHeight!) ?? 0
        let weight:Int = Int(stringWeight!) ?? 0
        
        var historyArray = HistoryLogController.history()
        
        if height == 0 || weight == 0 {
            resultLabel.text = "Error!"
            result2Label.text = "Bad Input!"
        } else {
            if unitSystemBoolean {
                //Standard System
                //703 times weight(lb) divided by height in inches squared
                
                let BMI:Float = (Float(703) * Float(weight)) / (Float(height) * Float(height))
                if (BMI < 0 || BMI > 100) {
                    resultLabel.text = "Error!"
                    result2Label.text = "Bad Input!"
                }
                else {
                    resultLabel.text = "BMI = \(BMI)"
                    historyArray.append(BMI)
                    HistoryLogController.addToHistory(floatToAdd: BMI)
                    if BMI < 18.5 {
                        result2Label.text = "You are Underweight"
                    }
                    else if BMI < 25 {
                        result2Label.text = "You are Average Weight"
                    }
                    else if BMI > 25 {
                        result2Label.text = "You are Overweight"
                    }
                }
            }
            else {
                //Metric System
                //Weight(kg) divided by height in meters squared.
                let realHeight:Float = Float(height)/Float(100)
                let BMI:Float = Float(weight) / (Float(realHeight) * Float(realHeight))
                if (BMI < 0 || BMI > 100) {
                    resultLabel.text = "Error!"
                    result2Label.text = "Bad Input!"
                }
                else {
                    resultLabel.text = "BMI = \(BMI)"
                    historyArray.append(BMI)
                    HistoryLogController.addToHistory(floatToAdd: BMI)
                    if BMI < 18.5 {
                        result2Label.text = "You are Underweight"
                    }
                    else if BMI < 25 {
                        result2Label.text = "You are Average Weight"
                    }
                    else if BMI > 25 {
                        result2Label.text = "You are Overweight"
                    }
                }
            }
        }
        
    }
    
    @IBAction func HistoryButtonTapped(_ sender: Any) {
        
        let historyViewController = storyboard?.instantiateViewController(withIdentifier: "HistoryViewController")
        
        self.present(historyViewController!, animated: true, completion: nil)
    }
}
