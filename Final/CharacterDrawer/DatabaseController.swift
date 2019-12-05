//
//  DatabaseController.swift
//  P5
//
//  Created by user159305 on 10/26/19.
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import Foundation
import CoreData

class DatabaseController {
    
    static var persistentContainer: NSPersistentContainer? = nil
    
    static func managedObjectContext() -> NSPersistentContainer {
        
        if( persistentContainer == nil) {
            persistentContainer = NSPersistentContainer(name: "CharacterDrawer")
            persistentContainer!.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
        }
        return persistentContainer!∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂∂
    }

    // MARK: - Core Data Saving support

    static func saveContext () {
        if let context = persistentContainer?.viewContext {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
}
