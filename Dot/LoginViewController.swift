//
//  LoginViewController.swift
//  Dot
//
//  Created by Titus Cheng on 11/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, DotHTTPRequestDelegate
{
    @IBOutlet weak var loginTableView: DotTableView!
    
    var status:String!
    
    var myAccount:Account!
    var keyholder:KeyboardPlaceHolder!
    var dotLogin: DotRequestLogin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginTableView.delegate = self;
        self.loginTableView.dataSource = self;
        self.loginTableView.registerNib(UINib(nibName: Data.loginItemNibName(), bundle: nil), forCellReuseIdentifier: Data.loginItemNibID())
        myAccount = Account.sharedInstance
        keyholder = KeyboardPlaceHolder.sharedInstance
        keyholder.store = NSMutableDictionary()
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "authenticateUser")
        swipeDown.numberOfTouchesRequired = 1
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "returnToPreviousScreen")
        swipeRight.numberOfTouchesRequired = 1
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        dotLogin = DotRequestLogin()
        dotLogin.delegate = self

    }
    
    func returnToPreviousScreen() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func authenticateUser() {
        if(myAccount.username != nil && myAccount.password != nil) {
            var userData = NSMutableDictionary()
            userData.setValue(myAccount.username, forKey: "username")
            userData.setValue(myAccount.password, forKey: "pass")
            dotLogin.startRequest(userData)
        }
    }
    
    
    func DotHTTPRequestDidReceiveData(data: NSDictionary) {
        if((data["error"] as String) == "") {
            myAccount.session_id = data["user_sessionid"] as String
            myAccount.user_id = data["user_id"] as String
            myAccount.isAuthenticated = true
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.loginTableView.reloadData()
        })
        println(data)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: LoginItem = tableView.dequeueReusableCellWithIdentifier(Data.loginItemNibID()) as LoginItem
        cell.itemLabel.font = UIFont(name: Data.defaultFontFamily(), size: Data.defaultFontSize())
        
        var loginName = Data.loginNames()[indexPath.row]
        //Check if anything has been entered from the keyboard
        if(keyholder.store!.objectForKey(loginName) != nil) {
            var input:String = keyholder.store.objectForKey(loginName) as String
            if(loginName == "Password") {
                var pass = ""
                for(var i = 0; i < countElements(input); i++) {
                    pass += "*"
                }
                cell.nameLabel.text = pass
                myAccount.password = input
            }
            if(loginName == "Username") {
                cell.nameLabel.text = input
                myAccount.username = input
            }
        } else {
            cell.nameLabel.text = ""
        }
        if(loginName == "Logged in as ") {
            if(myAccount.isAuthenticated) {
                cell.nameLabel.text = loginName + myAccount.username
            } else {
                cell.itemLabel.text = ""
                cell.nameLabel.text = ""
            }
        } else {
            cell.itemLabel.text = loginName
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let vc: ViewController = self.storyboard?.instantiateViewControllerWithIdentifier(Data.keyboardViewControllerID()) as ViewController
        vc.setKey(Data.loginNames()[indexPath.row])
        cell.destinationController = vc
        cell.viewController = self
        
        return cell

    }
    
    
    override func viewDidAppear(animated: Bool) {
        loginTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.loginNames().count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Data.loginItemHeight()
    }
    
}
