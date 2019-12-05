//
//  DrawView.swift
//  P5
//
//  Created by user159305 on 11/13/19.
//  Copyright © 2019 Carson Smith. All rights reserved.
//

import UIKit

class DrawView: UIView {

    var lineArray: [[CGPoint]] = []
    var change = true
    
    override func draw(_ rect: CGRect) {
        if(change) {
            super.draw(rect)
        
            guard let context = UIGraphicsGetCurrentContext() else { return }
        
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(5)
            context.setLineCap(.round)
        
            lineArray.forEach { (line) in
                for (i, p) in line.enumerated() {
                    if(i == 0) {
                        context.move(to: p)
                    } else {
                        context.addLine(to: p)
                    }
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(change) {
            lineArray.append([CGPoint]())
        }
    }
    
    //Called whenever there is movement from the touch.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(change) {
            //Sets a variable for the point the user has moved their finger to.
            guard let pointValues = touches.first?.location(in: self) else { return }
            //a new line from the lastPoint to the newPoint
        
            guard var lastLine = lineArray.popLast() else { return }
            lastLine.append(pointValues)
        
            lineArray.append(lastLine)
            //makes it so the next movement is from the newPoint instead of from the last
            self.setNeedsDisplay()
        }
    }

    func clearDrawView() {
        lineArray.removeAll()
        self.setNeedsDisplay()
    }
    
    func undoLastLine() {
        if lineArray.count > 0 {
            lineArray.removeLast()
        }
        self.setNeedsDisplay()
    }
    
    func toggleChangeable() {
        if(change) {
            change = false
        } else {
            change = true
        }
    }
}
