//
//  AppDelegate.swift
//  P5
//
//  Created by user159305 on 10/25/19.
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func prepopulate() {
        
        let context = DatabaseController.managedObjectContext().viewContext
        let newJPCLarge:JPCharacter = JPCharacter(context: context)
        
        newJPCLarge.jpCharKeyword = "Large"
        newJPCLarge.jpCharLiteralChar = "大"
        newJPCLarge.jpCharOnReading = "ダイ, タイ"
        newJPCLarge.jpCharKunReading = "おお-"
        newJPCLarge.jpCharStrokeCount = 3
        newJPCLarge.jpCharImage = "JPLarge.png"
        
        let newJPCDepression:JPCharacter = JPCharacter(context: context)
        
        newJPCDepression.jpCharKeyword = "Depression"
        newJPCDepression.jpCharLiteralChar = "鬱"
        newJPCDepression.jpCharOnReading = "ウツ"
        newJPCDepression.jpCharKunReading = "うっ(する), ふさ(ぐ), しげ(る)"
        newJPCDepression.jpCharStrokeCount = 29
        newJPCDepression.jpCharImage = "JPDepression.png"
        
        let newJPCCar:JPCharacter = JPCharacter(context: context)
        
        newJPCCar.jpCharKeyword = "Car"
        newJPCCar.jpCharLiteralChar = "車"
        newJPCCar.jpCharOnReading = "シャ"
        newJPCCar.jpCharKunReading = "くるま"
        newJPCCar.jpCharStrokeCount = 7
        newJPCCar.jpCharImage = "JPCar.png"
        
        let newJPCKing:JPCharacter = JPCharacter(context: context)
        
        newJPCKing.jpCharKeyword = "King"
        newJPCKing.jpCharLiteralChar = "王"
        newJPCKing.jpCharOnReading = "オウ"
        newJPCKing.jpCharKunReading = "" //There is no Kun reading.
        newJPCKing.jpCharStrokeCount = 4
        newJPCKing.jpCharImage = "JPKing.png"
        
        let newJPCTree:JPCharacter = JPCharacter(context: context)
        
        newJPCTree.jpCharKeyword = "Tree"
        newJPCTree.jpCharLiteralChar = "木"
        newJPCTree.jpCharOnReading = "ボク, モク"
        newJPCTree.jpCharKunReading = "き"
        newJPCTree.jpCharStrokeCount = 4
        newJPCTree.jpCharImage = "JPTree.png"
        
        let newJPCOre:JPCharacter = JPCharacter(context: context)
        
        newJPCOre.jpCharKeyword = "I/me (ore)"
        newJPCOre.jpCharLiteralChar = "俺"
        newJPCOre.jpCharOnReading = "エン"
        newJPCOre.jpCharKunReading = "おれ"
        newJPCOre.jpCharStrokeCount = 10
        newJPCOre.jpCharImage = "JPOre.png"

        //Create a total of 3 testing CN Characters.
        let newCNCGirl:CNCharacter = CNCharacter(context: context)
        
        newCNCGirl.cnCharKeyword = "Girl"
        newCNCGirl.cnCharLiteralChar = "女"
        newCNCGirl.cnCharImage = "CNGirl.png"
        newCNCGirl.cnCharReading = "nǚ"
        newCNCGirl.cnCharStrokeCount = 3
        
        let newCNCBoy:CNCharacter = CNCharacter(context: context)
        
        newCNCBoy.cnCharKeyword = "Boy"
        newCNCBoy.cnCharLiteralChar = "男"
        newCNCBoy.cnCharReading = "nán"
        newCNCBoy.cnCharImage = "CNBoy.png"
        newCNCBoy.cnCharStrokeCount = 7
        
        let newCNCMouth:CNCharacter = CNCharacter(context: context)
        
        newCNCMouth.cnCharKeyword = "Mouth"
        newCNCMouth.cnCharLiteralChar = "口"
        newCNCMouth.cnCharReading = "kǒu"
        newCNCMouth.cnCharImage = "CNMouth.png"
        newCNCMouth.cnCharStrokeCount = 3
        
        //Finally, save the context for the app so that these values are stored within CoreData.
        DatabaseController.saveContext()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        _ = DatabaseController.managedObjectContext()
        
        // Allows the database to prepopulate with all relevant character data on the first boot of the application. (Disabled until
        if (!UserDefaults.standard.bool(forKey: "isFirstBoot")) {
            prepopulate()
            UserDefaults.standard.set(true, forKey: "isFirstBoot")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
