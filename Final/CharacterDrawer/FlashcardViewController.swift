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
    @IBOutlet weak var HistoryButton: UIButton!
    @IBOutlet weak var KeywordLabel : UILabel!
    @IBOutlet weak var DrawingCanvas: DrawView!
    @IBOutlet weak var StrokeCountLabel: UILabel!
    @IBOutlet weak var LanguageLabel: UILabel!
    @IBOutlet weak var ReadingLabel1: UILabel!
    @IBOutlet weak var ReadingLabel2: UILabel!
    
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    var context = DatabaseController.managedObjectContext().viewContext
    var language:String = ""
    var fetchResultsJP:[JPCharacter] = []
    var fetchResultsCN:[CNCharacter] = []
    var randomNumber = 0
    var keywrd:String = ""
    //var dataJP:JPCharacter = JPCharacter(context: DatabaseController.managedObjectContext().viewContext) //Ask about if this is okay
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        ImageView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        ImageView.layer.cornerRadius = 5.0
        ImageView.layer.borderWidth = 2
        ImageView.contentMode = .scaleAspectFit
        //Above code simply gives it a border.
        DrawingCanvas.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        DrawingCanvas.layer.cornerRadius = 5
        DrawingCanvas.layer.borderWidth = 2
        DrawingCanvas.contentMode = .scaleAspectFit
        CorrectButton.layer.cornerRadius = 50
        WrongButton.layer.cornerRadius = 50
        HistoryButton.layer.cornerRadius = 10
        BackButton.layer.cornerRadius = 10
        doneButton.layer.cornerRadius = 10
        undoButton.layer.cornerRadius = 10
        CorrectButton.isHidden = true
        WrongButton.isHidden = true
        ImageView.isHidden = true
        
        if( self.restorationIdentifier == "FlashcardCNViewController") {
            language = "Chinese"
            LanguageLabel.text = "CN"
            //LanLabel.text = language
        } else if self.restorationIdentifier == "FlashcardJPViewController" {
            language = "Japanese"
            LanguageLabel.text = "JP"
            //LanLabel.text = language
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
            KeywordLabel.text = "\(dataJP.jpCharKeyword ?? "")"
            StrokeCountLabel.text = "Strokes: \(String(dataJP.jpCharStrokeCount))"
            
            if(dataJP.jpCharOnReading!.count > 0) {
                ReadingLabel1.text = "On Readings: \(dataJP.jpCharOnReading ?? "")"
            } else {
                ReadingLabel1.text = "On Readings: None"
            }
            if(dataJP.jpCharKunReading!.count > 0) {
                ReadingLabel2.text = "Kun Readings: \(dataJP.jpCharKunReading ?? "")"
            } else {
                ReadingLabel2.text = "Kun Readings: None"
            }
            
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
            StrokeCountLabel.text = "Strokes: \(String(dataCN.cnCharStrokeCount))"
            KeywordLabel.text = "\(dataCN.cnCharKeyword ?? "")"
            if(dataCN.cnCharReading!.count > 0) {
                ReadingLabel1.text = "Readings: \(dataCN.cnCharReading ?? "")"
            } else {
                ReadingLabel1.text = "Readings: None"
            }
        }
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        DrawingCanvas.toggleChangeable()
        WrongButton.isHidden = false
        CorrectButton.isHidden = false
        BackButton.isHidden = true
        HistoryButton.isHidden = true
        ImageView.isHidden = false
        doneButton.isHidden = true
        undoButton.isHidden = true
        ReadingLabel1.isHidden = true
        if(language == "Japanese") {
            ReadingLabel2.isHidden = true
        }
    }
    
    @IBAction func undoButtonPressed(_ sender: Any) {
        DrawingCanvas.undoLastLine()
    }
    func getAndSetNewInfo() -> Int {
        let lastRandomNumber = randomNumber
        if language == "Japanese" {
           
            randomNumber = Int.random(in: 0 ..< (fetchResultsJP.count))
            while randomNumber == lastRandomNumber {
                randomNumber = Int.random(in: 0 ..< (fetchResultsJP.count))
            }
            
            let dataJP = fetchResultsJP[randomNumber]
            
            KeywordLabel.text = "\(dataJP.jpCharKeyword ?? "")"
            StrokeCountLabel.text = "Strokes: \(String(dataJP.jpCharStrokeCount))"
            ImageView.image = UIImage(named: dataJP.jpCharImage ?? "")
            if(dataJP.jpCharOnReading!.count > 0) {
                ReadingLabel1.text = "On Readings: \(dataJP.jpCharOnReading ?? "")"
            } else {
                ReadingLabel1.text = "On Readings: None"
            }
            if(dataJP.jpCharKunReading!.count > 0) {
                ReadingLabel2.text = "Kun Readings: \(dataJP.jpCharKunReading ?? "")"
            } else {
                ReadingLabel2.text = "Kun Readings: None"
            }
            
        } else if language == "Chinese" {
            randomNumber = Int.random(in: 0 ..< (fetchResultsCN.count))
            while randomNumber == lastRandomNumber {
                randomNumber = Int.random(in: 0 ..< (fetchResultsCN.count))
            }
            
            let dataCN = fetchResultsCN[randomNumber]
            
            KeywordLabel.text = "\(dataCN.cnCharKeyword ?? "")"
            StrokeCountLabel.text = "Strokes: \(String(dataCN.cnCharStrokeCount))"
            ImageView.image = UIImage(named: dataCN.cnCharImage ?? "")
            if(dataCN.cnCharReading!.count > 0) {
                ReadingLabel1.text = "Readings: \(dataCN.cnCharReading ?? "")"
            } else {
                ReadingLabel1.text = "Readings: None"
            }
            
        }
        return lastRandomNumber
    }
    
    @IBAction func correctButtonPressed(_ sender: Any) {
        
        let lastInfoRefNumber = getAndSetNewInfo()
        let newHistoryResult:CharacterHistory = CharacterHistory(context: context)
        let renderer = UIGraphicsImageRenderer(size: DrawingCanvas.bounds.size)
        let newHistoryImage = renderer.image { ctx in DrawingCanvas.drawHierarchy(in: DrawingCanvas.bounds, afterScreenUpdates: true)
        }
        let imageData = newHistoryImage.pngData()
        newHistoryResult.historyImage = imageData
        newHistoryResult.historyResult = "Correct"
        newHistoryResult.historyDate = "\(Date())"

        if language == "Japanese" {
            let lastCharData = fetchResultsJP[lastInfoRefNumber]
            lastCharData.addToJCharHistory(newHistoryResult)
            ReadingLabel2.isHidden = false
        } else if language == "Chinese" {
            let lastCharData = fetchResultsCN[lastInfoRefNumber]
            lastCharData.addToCCharHistory(newHistoryResult)
        }
        DatabaseController.saveContext()
        CorrectButton.isHidden = true
        WrongButton.isHidden = true
        BackButton.isHidden = false
        HistoryButton.isHidden = false
        ImageView.isHidden = true
        doneButton.isHidden = false
        undoButton.isHidden = false
        ReadingLabel1.isHidden = false
        DrawingCanvas.clearDrawView()
        DrawingCanvas.toggleChangeable()
    }
    
    @IBAction func wrongButtonPressed(_ sender: Any) {
        
        //Getting and setting new info
        let lastInfoRefNumber = getAndSetNewInfo()
        
        //Making a new history result
        let newHistoryResult:CharacterHistory = CharacterHistory(context: context)
        
        //Saving and storing the DrawingCanvas as an image.
        let renderer = UIGraphicsImageRenderer(size: DrawingCanvas.bounds.size)
        let newHistoryImage = renderer.image { ctx in DrawingCanvas.drawHierarchy(in: DrawingCanvas.bounds, afterScreenUpdates: true)
        }
        let imageData = newHistoryImage.pngData()
        newHistoryResult.historyImage = imageData
        
        
        newHistoryResult.historyResult = "Incorrect"
        newHistoryResult.historyDate = "\(Date())"
        
        if language == "Japanese" {
            let lastCharData = fetchResultsJP[lastInfoRefNumber]
            lastCharData.addToJCharHistory(newHistoryResult)
            ReadingLabel2.isHidden = false
        } else if language == "Chinese" {
            let lastCharData = fetchResultsCN[lastInfoRefNumber]
            lastCharData.addToCCharHistory(newHistoryResult)
        }

        DatabaseController.saveContext()
        CorrectButton.isHidden = true
        WrongButton.isHidden = true
        BackButton.isHidden = false
        HistoryButton.isHidden = false
        ImageView.isHidden = true
        doneButton.isHidden = false
        undoButton.isHidden = false
        ReadingLabel1.isHidden = false
        DrawingCanvas.clearDrawView()
        DrawingCanvas.toggleChangeable()
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
