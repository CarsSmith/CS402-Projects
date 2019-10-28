//
//  HistoryViewController.swift
//  P5
//
//  Created by user159305 on 10/27/19.
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var context = DatabaseController.managedObjectContext().viewContext
    var fetchResultsJP:[JPCharacter] = []
    var fetchResultsCN:[CNCharacter] = []
    var language = ""
    
    @IBOutlet weak var tableViewReference: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 75
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell")!
        
        
        //print(fetchResultsJP[indexPath.section].jCharHistory)
        //ACCESSING HISTORY VALUES DOESN'T WORK HERE FOR ?????? REASONS.
        
        
        
        if language == "Japanese" {
            cell.textLabel?.text = "\(fetchResultsJP[indexPath.section].jpCharLiteralChar ?? "") Keyword: \(fetchResultsJP[indexPath.section].jpCharKeyword ?? "")"
        } else {
            cell.textLabel?.text = "\(fetchResultsCN[indexPath.section].cnCharLiteralChar ?? "") Keyword: \(fetchResultsCN[indexPath.section].cnCharKeyword ?? "")"
        }
        return cell
    }
}
