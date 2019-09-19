//
//  HistoryLogController.swift
//  BMICalculator
//
//  Created by user159305 on 9/18/19.
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import Foundation

class HistoryLogController: NSObject {

    static var historyArray = Array<Float>()
    
    class func history() -> Array<Float>{
        
        return HistoryLogController.historyArray
    }
    
    
    static func addToHistory(floatToAdd:Float){
        HistoryLogController.historyArray.append(floatToAdd)
        
        print(HistoryLogController.historyArray)
    }
}
