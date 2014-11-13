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
        
        var twoSwipeRight = UISwipeGestureRecognizer(target: self, action: "authenticateUser")
        twoSwipeRight.numberOfTouchesRequired = 2
        twoSwipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(twoSwipeRight)
        
        dotLogin = DotRequestLogin()
        dotLogin.delegate = self
        
    }
    
    func authenticateUser() {
        if(myAccount.username != nil && myAccount.password != nil) {
            var data = NSMutableDictionary()
            data.setValue(myAccount.username, forKey: "username")
            data.setValue((myAccount.password), forKey: "pass")
            dotLogin.startRequest(ToRequestLogin: data)
        }
    }
    
    func DotHTTPRequestDidReceiveData(data: NSDictionary) {
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
                for(var i = 0; i < countElements(loginName); i++) {
                    pass += "*"
                }
                cell.nameLabel.text = pass
                myAccount.username = input
            }
            if(loginName == "Username") {
                cell.nameLabel.text = input
                myAccount.password = input
            }
        } else {
            cell.nameLabel.text = ""
        }
        if(loginName == "Logged in as") {
            
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
