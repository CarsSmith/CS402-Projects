//
//  ChineseViewController.swift
//  P5
//
//  Created by user159305 on 10/26/19.
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import UIKit

class ChineseViewController: UIViewController {

    @IBOutlet weak var cnBackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cnBackButtonTapped(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
