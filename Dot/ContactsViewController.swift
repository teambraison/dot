//
//  ContactsViewController.swift
//  Dot
//
//  Created by Titus Cheng on 11/3/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class ContactsViewController:UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var contactsTableView: UITableView!
    
    var contactNames = ["Pete Carol", "Steve Johnson", "Grandpa Jim"]
    var messages = ["Hey, where are you?", "Been trying to find that thing in the garage", "I'm coming home tonight to eat dinner"]
    
    override func viewDidLoad() {
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        self.contactsTableView.registerNib(UINib(nibName: "MenuItem", bundle: nil), forCellReuseIdentifier: "menuitem")
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "returnToPreviousScreen")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func returnToPreviousScreen()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell = UITableViewCell()
//        cell.textLabel.text = contactNames[indexPath.row]
//        cell.detailTextLabel?.text = messages[indexPath.row]
        var cell: MenuItem = tableView.dequeueReusableCellWithIdentifier("menuitem") as MenuItem
        cell.itemLabel.font = UIFont(name: "Helvetica Neue", size: 35)
        cell.itemLabel.text = contactNames[indexPath.row] + ": " + messages[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            var contactsViewController: ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("keyboard") as ViewController
            self.navigationController?.pushViewController(contactsViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MenuItem.height()
    }
    
}
