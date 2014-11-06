//
//  PlaceHolder.swift
//  Dot
//
//  Created by Titus Cheng on 11/4/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class PlaceHolder:UIViewController
{
    override func viewDidLoad() {
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "returnToPreviousScreen")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func returnToPreviousScreen() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
