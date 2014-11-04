//
//  ViewController.swift
//  Dot
//
//  Created by Titus Cheng on 10/23/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var characters = [["A", "B", "C", "D", "E", "F"], ["G", "H", "I", "J", "K", "L"], ["M", "N", "O", "P", "Q", "R"], ["S", "T", "U", "V", "W", "X"], ["Y", "Z", "1", "2", "3", "4"], ["5","6", "7", "8", "9", "0"]]

    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var groupOne: UIView!
    @IBOutlet weak var groupTwo: UIView!
    @IBOutlet weak var groupThree: UIView!
    @IBOutlet weak var groupFour: UIView!
    @IBOutlet weak var groupFive: UIView!
    @IBOutlet weak var groupSix: UIView!
    var groups : [UIView] = []
    var groupIndex = -1
    var textIndex = -1
    var shouldReset = false
    var output = ""
    
    @IBOutlet weak var resetPressed: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        var oneTap = UITapGestureRecognizer(target: self, action:"viewTapped")
        addTapGestureToUI(groupOne)
        addTapGestureToUI(groupTwo)
        addTapGestureToUI(groupThree)
        addTapGestureToUI(groupFour)
        addTapGestureToUI(groupFive)
        addTapGestureToUI(groupSix)
        groups.insert(groupOne, atIndex: 0)
        groups.insert(groupTwo, atIndex: 1)
        groups.insert(groupThree, atIndex: 2)
        groups.insert(groupFour, atIndex:3)
        groups.insert(groupFive, atIndex:4)
        groups.insert(groupSix, atIndex:5)
        outputLabel.text = ""
        
        resetPressed.addTarget(self, action: "resetTapped", forControlEvents: .TouchUpInside)
        
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "returnToPreviousScreen")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func returnToPreviousScreen()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func addTapGestureToUI(theView: UIView) {
        var oneTap = UITapGestureRecognizer(target: self, action:"viewTapped:")
        oneTap.delegate = self;
        theView.addGestureRecognizer(oneTap)
    }
    
    func resetTapped() {
        println("Reset button pressed")
        output = ""
        outputLabel.text = ""
    }
    
    
    func viewTapped(tapGesture:UITapGestureRecognizer) {
            if(groupIndex == -1) {
                groupIndex = getIndex(tapGesture.view!)
     //           println("Group \(groupIndex) selected")
            } else if(textIndex == -1) {
                textIndex = getIndex(tapGesture.view!)
       //         println("Text position \(textIndex) selected")
                output += (characters[groupIndex][textIndex])
                outputLabel.text = output
                println(characters[groupIndex][textIndex])
                groupIndex = -1
                textIndex = -1
            }
    }
    
    func getIndex(theView: UIView) -> Int {
        var index = 0
        for(var i = 0; i < groups.count; i++) {
            if(theView === groups[i]) {
                index = i
            }
        }
        return index
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

