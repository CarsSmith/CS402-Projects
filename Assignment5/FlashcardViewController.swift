//
//  FlashcardViewController.swift
//  P5
//
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import UIKit
import CoreData

class FlashcardViewController: UIViewController {

    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var WrongButton: UIButton!
    @IBOutlet weak var CorrectButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var LanLabel : UILabel!
    
    var context = DatabaseController.managedObjectContext().viewContext
    var language:String = ""
    var fetchResultsJP:[JPCharacter] = []
    var fetchResultsCN:[CNCharacter] = []
    var randomNumber = 0
    var keywrd:String = ""
    //var dataJP:JPCharacter = JPCharacter(context: DatabaseController.managedObjectContext().viewContext) //Ask about if this is okay
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if( self.restorationIdentifier == "FlashcardCNViewController") {
            language = "Chinese"
            LanLabel.text = language
        } else if self.restorationIdentifier == "FlashcardJPViewController" {
            language = "Japanese"
            LanLabel.text = language
        }
       
        if language == "Japanese" {
            let fetchRequest:NSFetchRequest<JPCharacter> = JPCharacter.fetchRequest()
            do {
                fetchResultsJP = try context.fetch(fetchRequest)
            } catch {
                print(error)
            }
            randomNumber = Int.random(in: 0 ..< (fetchResultsJP.count))
            let dataJP = fetchResultsJP[randomNumber]
            keywrd = dataJP.jpCharKeyword!
            //LanLabel.text = "Keyword: \(dataJP.jpCharKeyword ?? "")"
            ImageView.image = UIImage(named: dataJP.jpCharImage ?? "")
            
        } else if language == "Chinese" {
            let fetchRequest:NSFetchRequest<CNCharacter> = CNCharacter.fetchRequest()
            do {
                fetchResultsCN = try context.fetch(fetchRequest)
            } catch {
                print(error)
            }
            randomNumber = Int.random(in: 0 ..< (fetchResultsCN.count))
            let dataCN = fetchResultsCN[randomNumber]
            keywrd = dataCN.cnCharKeyword!
            //LanLabel.text = "Keyword: \(dataJP.jpCharKeyword ?? "")"
            ImageView.image = UIImage(named: dataCN.cnCharImage ?? "")
            
        }
    }
    
    func getAndSetNewInfo() -> Int {
        let lastRandomNumber = randomNumber
        if language == "Japanese" {
           
            randomNumber = Int.random(in: 0 ..< (fetchResultsJP.count))
            while randomNumber == lastRandomNumber {
                randomNumber = Int.random(in: 0 ..< (fetchResultsJP.count))
            }
            
            //LanLabel.text = "Answer: \(keywrd)"
            //TODO - Delay and show the answer to the user.
            let dataJP = fetchResultsJP[randomNumber]
            
            LanLabel.text = "Keyword: \(dataJP.jpCharKeyword ?? "")"
            ImageView.image = UIImage(named: dataJP.jpCharImage ?? "")
            
        } else if language == "Chinese" {
            randomNumber = Int.random(in: 0 ..< (fetchResultsCN.count))
            while randomNumber == lastRandomNumber {
                randomNumber = Int.random(in: 0 ..< (fetchResultsCN.count))
            }
            
            //LanLabel.text = "Answer: \(keywrd)"
            //TODO - Delay and show the answer to the user.
            let dataCN = fetchResultsCN[randomNumber]
            
            LanLabel.text = "Keyword: \(dataCN.cnCharKeyword ?? "")"
            ImageView.image = UIImage(named: dataCN.cnCharImage ?? "")
        }
        return lastRandomNumber
    }
    
    @IBAction func correctButtonPressed(_ sender: Any) {
        
        let lastInfoRefNumber = getAndSetNewInfo()
        let newHistoryResult:CharacterHistory = CharacterHistory(context: context)
        newHistoryResult.historyResult = "Correct"
        newHistoryResult.historyDate = "\(Date())"

        if language == "Japanese" {
            let lastCharData = fetchResultsJP[lastInfoRefNumber]
            lastCharData.addToJCharHistory(newHistoryResult)
            
        } else if language == "Chinese" {
            let lastCharData = fetchResultsCN[lastInfoRefNumber]
            lastCharData.addToCCharHistory(newHistoryResult)
        }
        DatabaseController.saveContext()
    }
    
    @IBAction func wrongButtonPressed(_ sender: Any) {
        
        let lastInfoRefNumber = getAndSetNewInfo()
        
        let newHistoryResult:CharacterHistory = CharacterHistory(context: context)
        
        newHistoryResult.historyResult = "Incorrect"
        newHistoryResult.historyDate = "\(Date())"
        
        if language == "Japanese" {
            let lastCharData = fetchResultsJP[lastInfoRefNumber]
            lastCharData.addToJCharHistory(newHistoryResult)

        } else if language == "Chinese" {
            let lastCharData = fetchResultsCN[lastInfoRefNumber]
            lastCharData.addToCCharHistory(newHistoryResult)
        }

        DatabaseController.saveContext()
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        if language == "Japanese" {
            let historyViewController = storyboard?.instantiateViewController(identifier: "JPHistoryViewController")
            self.present(historyViewController!, animated: true, completion: nil)
        } else {
            let historyViewController = storyboard?.instantiateViewController(identifier: "CNHistoryViewController")
            self.present(historyViewController!, animated: true, completion: nil)        }
    }
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
