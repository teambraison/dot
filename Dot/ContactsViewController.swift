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
    
    var contactNames = ["Eric Kim", "Mason Joo", "Jason Lee", "Kikwang Sung"]
    var messages = ["야 오디야", "아이퐁 식스", "I'm coming home tonight to eat dinner", "그럼"]
    
    override func viewDidLoad() {
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        self.contactsTableView.registerNib(UINib(nibName: "ContactItem", bundle: nil), forCellReuseIdentifier: "contactitem")
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "returnToPreviousScreen")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func returnToPreviousScreen()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: ContactItem = tableView.dequeueReusableCellWithIdentifier("contactitem") as ContactItem
        cell.contactName.font = UIFont(name: "Helvetica Neue", size: 35)
        cell.contactName.text = contactNames[indexPath.row]
        cell.contactMessage.text = messages[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
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
