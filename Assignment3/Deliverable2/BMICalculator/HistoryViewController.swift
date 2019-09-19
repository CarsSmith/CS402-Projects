//
//  HistoryViewController.swift
//  BMICalculator
//
//  Created by user159305 on 9/18/19.
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var infoLabel2: UILabel!
    @IBOutlet weak var infoLabel1: UILabel!
    @IBOutlet weak var bmiLabel2: UILabel!
    @IBOutlet weak var bmiLabel1: UILabel!
    @IBOutlet weak var infoLabel3: UILabel!
    @IBOutlet weak var bmiLabel3: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let histArray = HistoryLogController.history()
        let bmi1:Float
        let bmi2:Float
        let bmi3:Float
        
        //This is some immensely sloppy and unoptimized code, but it gets the job done at 2AM when I gotta get something submitted. Hopefully it doesn't get any points subtracted! I kinda bit off more than I could chew for a single day.
        if histArray.count >= 3 {
            bmi1 = histArray[histArray.count-1]
            bmi2 = histArray[histArray.count-2]
            bmi3 = histArray[histArray.count-3]
            bmiLabel1.text = "\(bmi1)"
            bmiLabel2.text = "\(bmi2)"
            bmiLabel3.text = "\(bmi3)"
            if bmi1 < 18.5 {
                infoLabel1.text = "Low"
            }
            else if bmi1 < 25 {
                infoLabel1.text = "Average"
            }
            else if bmi1 >= 25 {
                infoLabel1.text = "High"
            }
            
            if bmi2 < 18.5 {
                infoLabel2.text = "Low"
            }
            else if bmi2 < 25 {
                infoLabel2.text = "Average"
            }
            else if bmi2 >= 25 {
                infoLabel2.text = "High"
            }
            
            if bmi3 < 18.5 {
                infoLabel3.text = "Low"
            }
            else if bmi3 < 25 {
                infoLabel3.text = "Average"
            }
            else if bmi3 >= 25 {
                infoLabel3.text = "High"
            }
        }
        else if histArray.count >= 2 {
            bmi1 = histArray[histArray.count-1]
            bmi2 = histArray[histArray.count-2]
            bmiLabel1.text = "\(bmi1)"
            bmiLabel2.text = "\(bmi2)"
            
            if bmi1 < 18.5 {
                infoLabel1.text = "Low"
            }
            else if bmi1 < 25 {
                infoLabel1.text = "Average"
            }
            else if bmi1 >= 25 {
                infoLabel1.text = "High"
            }
            
            if bmi2 < 18.5 {
                infoLabel2.text = "Low"
            }
            else if bmi2 < 25 {
                infoLabel2.text = "Average"
            }
            else if bmi2 >= 25 {
                infoLabel2.text = "High"
            }
        }
        else if histArray.count >= 1 {
            bmi1 = histArray[histArray.count-1]
            bmiLabel1.text = "\(bmi1)"
            
            if bmi1 < 18.5 {
                infoLabel1.text = "Low"
            }
            else if bmi1 < 25 {
                infoLabel1.text = "Average"
            }
            else if bmi1 >= 25 {
                infoLabel1.text = "High"
            }
        }
    }
    
    @IBAction func ReturnButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

