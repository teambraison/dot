//
//  MenuViewTable.swift
//  Dot
//
//  Created by Titus Cheng on 11/3/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class MenuViewTable:UITableView, UIGestureRecognizerDelegate
{
    let enlargedTextSize:CGFloat = 50
    let originalTextSize:CGFloat = 40
    let fontFamilyName = "Helvetica Neue"
    var currentSelectedItem: MenuItem!
    var touchCount = 0
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        checkForTouchPoint(touches)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        touchCount++
        checkForTouchPoint(touches)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        println("Touch count is \(touchCount)")
        if(touchCount == 2) {
            touchCount = 0
            deselectMenuItem(currentSelectedItem)
            nextAction()
        } else if(touchCount == 1) {
            touchCount = 0
            deselectMenuItem(currentSelectedItem)
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func highlightSelectedMenuItem() {
        currentSelectedItem.itemLabel.font = UIFont(name: fontFamilyName, size:enlargedTextSize)
    }
    
    func deselectMenuItem(item: MenuItem) {
        item.itemLabel.font = UIFont(name: fontFamilyName, size:originalTextSize)
    }
    
    
    //Checking if the touching point is on one of the cells.
    func checkForTouchPoint(touch: NSSet){
        var cells = self.visibleCells()
        let point: CGPoint = touch.anyObject()!.locationInView(self) as CGPoint
        for(var i = 0; i < cells.count; i++)
        {
            var bounds = cells[i].bounds
            var item: MenuItem = cells[i] as MenuItem
            var r:CGRect = item.frame
            if(CGRectContainsPoint(r, point)) {
                currentSelectedItem = item
                highlightSelectedMenuItem()
            } else {
                deselectMenuItem(item)
            }
        }
    }
    
    func nextAction() {
        if(currentSelectedItem.viewController != nil && currentSelectedItem.destinationController != nil) {
            println("Pushing view controllers")
            currentSelectedItem!.viewController.navigationController?.pushViewController(currentSelectedItem!.destinationController, animated: true)
        } else {
            touchCount = 1
        }
    }
    
}
