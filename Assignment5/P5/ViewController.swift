//
//  ViewController.swift
//  P5
//
//  Created by user159305 on 10/25/19.
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var chineseOptionButton: UIButton!
    @IBOutlet weak var decorativeOrLabel: UILabel!
    @IBOutlet weak var japaneseOptionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }

    @IBAction func JPSelected(_ sender: Any) {
        let flashcardJPViewController = storyboard?.instantiateViewController(identifier: "FlashcardJPViewController")
        self.present(flashcardJPViewController!, animated: true, completion: nil)
    }
    
    @IBAction func CNSelected(_ sender: Any) {
        //TODO: THIS IS SET TO SEND EVERYTHING TO THE JP VIEWCONTROLLER. JUST GET JP WORKING FIRST OR SOMETHING
         let flashcardCNViewController = storyboard?.instantiateViewController(identifier: "FlashcardCNViewController")
        self.present(flashcardCNViewController!, animated: true, completion: nil)
    }
}

