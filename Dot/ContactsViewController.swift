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
    
    var contacts:[Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myAccount = Account.sharedInstance

        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        self.contactsTableView.registerNib(UINib(nibName: Data.contactItemNibName(), bundle: nil), forCellReuseIdentifier: Data.contactItemNibID())
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "returnToPreviousScreen")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        users = DotRequestAllUsers()
        users.delegate = self
        contacts = []
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let myAccount = Account.sharedInstance
        if(!myAccount.isAuthenticated) {
            let vc: LoginViewController = self.storyboard?.instantiateViewControllerWithIdentifier(Data.loginControllerID()) as LoginViewController
            self.navigationController?.pushViewController(vc, animated: false)
            
        }
        if(myAccount.isAuthenticated) {
            users.startRequest()
        }
    }
    
    func DotHTTPRequestDidReceiveData(data:NSDictionary) {
        contacts = []
        let contactList:[NSDictionary] = data.objectForKey("contacts")! as [NSDictionary]
        for(var i = 0; i < contactList.count; i++) {
            let theContact: NSDictionary = contactList[i] as NSDictionary
            let theName: NSString = theContact.objectForKey("username") as NSString
            let theID: NSString = theContact.objectForKey("userid") as NSString
            let contact = Contact(name: theName, id: theID)
            contacts.insert(contact, atIndex:i)
        }
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

        cell.contactName.text = contacts[indexPath.row].username
        cell.contactMessage.text = ""
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.viewController = self
        
        let vc: MessageViewController = self.storyboard?.instantiateViewControllerWithIdentifier(Data.messageViewControllerID()) as MessageViewController
        vc.setContact(contacts[indexPath.row])
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
