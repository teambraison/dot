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
    var longPress: Bool = false
    
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        checkForTouchPoint(touches)
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        checkForTouchPoint(touches)
    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        checkForTouchPoint(touches)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
            performChange(item, shouldChange:CGRectContainsPoint(r, point));
        }
    }
    
    //Performing the change the the text label
    func performChange(menuItem:MenuItem, shouldChange: Bool) {
        if(shouldChange) {
            //**Perform change only if touch point matches one of the cells**
            currentSelectedItem = menuItem
            menuItem.itemLabel.font = UIFont(name: fontFamilyName, size:enlargedTextSize)
        } else {
            menuItem.itemLabel.font = UIFont(name: fontFamilyName, size:originalTextSize)
        }
    }
    
    func longPressDetected() {
        longPress = true
    }
    
    func nextAction() {
        if(longPress) {
            if(currentSelectedItem.viewController != nil && currentSelectedItem.destinationController != nil) {
                println("It is working")
                currentSelectedItem!.viewController.navigationController?.pushViewController(currentSelectedItem!.destinationController, animated: true)
            }
        }

    }
    
}
