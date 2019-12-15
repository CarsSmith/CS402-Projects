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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chineseOptionButton: UIButton!
    @IBOutlet weak var japaneseOptionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        chineseOptionButton.layer.cornerRadius = 10
        japaneseOptionButton.layer.cornerRadius = 10
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }

    @IBAction func JPSelected(_ sender: Any) {
        let flashcardJPViewController = storyboard?.instantiateViewController(identifier: "FlashcardJPViewController")
        flashcardJPViewController!.modalPresentationStyle = .fullScreen
        self.present(flashcardJPViewController!, animated: true, completion: nil)
    }
    
    @IBAction func CNSelected(_ sender: Any) {
        
         let flashcardCNViewController = storyboard?.instantiateViewController(identifier: "FlashcardCNViewController")
        flashcardCNViewController!.modalPresentationStyle = .fullScreen
        self.present(flashcardCNViewController!, animated: true, completion: nil)
    }
}

