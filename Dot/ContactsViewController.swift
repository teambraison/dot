//
//  ContactsViewController.swift
//  Dot
//
//  Created by Titus Cheng on 11/3/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class ContactsViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, DotHTTPRequestDelegate
{
    @IBOutlet weak var contactsTableView: DotTableView!
    
    var users:DotRequestAllUsers!
    
    var contacts:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        self.contactsTableView.registerNib(UINib(nibName: Data.contactItemNibName(), bundle: nil), forCellReuseIdentifier: Data.contactItemNibID())
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "returnToPreviousScreen")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        users = DotRequestAllUsers()
        users.delegate = self
        users.startRequest()
        contacts = []
        
    }
    
    func DotHTTPRequestDidReceiveData(data:NSDictionary) {
        println("Received contacts information")
        contacts = data["names"]! as Array
        dispatch_async(dispatch_get_main_queue(), {
            self.contactsTableView.reloadData()
        })
    }
    
    func returnToPreviousScreen()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: ContactItem = tableView.dequeueReusableCellWithIdentifier(Data.contactItemNibID()) as ContactItem
        cell.contactName.font = UIFont(name: Data.defaultFontFamily(), size: Data.defaultFontSize())

        cell.contactName.text = contacts[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.viewController = self
        
        let vc: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier(Data.keyboardViewControllerID()) as UIViewController
        cell.destinationController = vc
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            var contactsViewController: ViewController = self.storyboard?.instantiateViewControllerWithIdentifier(Data.keyboardViewControllerID()) as ViewController
            self.navigationController?.pushViewController(contactsViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Data.contactItemHeight()
    }
    
}
