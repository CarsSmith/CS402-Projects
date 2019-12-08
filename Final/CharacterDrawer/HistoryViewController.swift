//
//  HistoryViewController.swift
//  P5
//
//  Created by user159305 on 10/27/19.
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import UIKit
import CoreData


class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var historyDefaultImageView: UIImageView!
    @IBOutlet weak var historyResultLabel: UILabel!
    @IBOutlet weak var historyDateLabel: UILabel!
    @IBOutlet weak var historyKeywordLabel: UILabel!
    @IBOutlet weak var historyAttemptImageView: UIImageView!
}


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var context = DatabaseController.managedObjectContext().viewContext
    var fetchResultsJP:[JPCharacter] = []
    var fetchResultsCN:[CNCharacter] = []
    var language = ""
    
    @IBOutlet weak var tableViewReference: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.registerTableViewCells()
        if( self.restorationIdentifier == "CNHistoryViewController") {
             language = "Chinese"
        } else if self.restorationIdentifier == "JPHistoryViewController" {
             language = "Japanese"
        }
        
         if language == "Japanese" {
             let fetchRequest:NSFetchRequest<JPCharacter> = JPCharacter.fetchRequest()
             do {
                 fetchResultsJP = try context.fetch(fetchRequest)
             } catch {
                 print(error)
             }
             
         } else if language == "Chinese" {
             let fetchRequest:NSFetchRequest<CNCharacter> = CNCharacter.fetchRequest()
             do {
                 fetchResultsCN = try context.fetch(fetchRequest)
             } catch {
                 print(error)
            }
         }
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if language == "Japanese" {
            return fetchResultsJP[section].jpCharKeyword
        } else {
            return fetchResultsCN[section].cnCharKeyword
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if language == "Japanese" {
            return fetchResultsJP.count
        } else {
            return fetchResultsCN.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if language == "Japanese" {
            return fetchResultsJP[section].jCharHistory!.count
        } else {
            return fetchResultsCN[section].cCharHistory!.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as! HistoryTableViewCell)
        
        if language == "Japanese" {
            let historySet = fetchResultsJP[indexPath.section].jCharHistory!
            let historyArray:[CharacterHistory] = historySet.allObjects as! [CharacterHistory]
            let historyItem = historyArray[indexPath.row]
            let historyItemDate = historyItem.historyDate
            let historyItemImage = historyItem.historyImage!
            let historyItemResult = historyItem.historyResult
            cell.historyDefaultImageView.image = UIImage(named: fetchResultsJP[indexPath.section].jpCharImage ?? "")
            cell.historyDateLabel.text = "Date: \(historyItemDate ?? "")"
            cell.historyResultLabel.text = "\(historyItemResult ?? "")"
            cell.historyKeywordLabel.text = "Keyword: \(fetchResultsJP[indexPath.section].jpCharKeyword ?? "")"
            
            let attemptImage:UIImage = UIImage(data: historyItemImage)!
            cell.historyAttemptImageView.image = attemptImage
        } else {
            let historySet = fetchResultsCN[indexPath.section].cCharHistory!
            let historyArray:[CharacterHistory] = historySet.allObjects as! [CharacterHistory]
            let historyItem = historyArray[indexPath.row]
            let historyItemDate = historyItem.historyDate
            let historyItemImage = historyItem.historyImage!
            let historyItemResult = historyItem.historyResult
            cell.historyDefaultImageView.image = UIImage(named: fetchResultsCN[indexPath.section].cnCharImage ?? "")
            cell.historyDateLabel.text = "Date: \(historyItemDate ?? "")"
            cell.historyResultLabel.text = "\(historyItemResult ?? "")"
            cell.historyKeywordLabel.text = "Keyword: \(fetchResultsCN[indexPath.section].cnCharKeyword ?? "")"
            
            let attemptImage:UIImage = UIImage(data: historyItemImage)!
            cell.historyAttemptImageView.image = attemptImage
        }
        return cell
    }
}
