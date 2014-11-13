//
//  DotAPI.swift
//  Dot
//
//  Created by Titus Cheng on 11/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation

protocol DotHTTPRequestDelegate
{
    func DotHTTPRequestDidReceiveData(data:NSDictionary)
}


class DotHTTPRequest
{
    let developmentURL = "http://localhost:3000"
    let stagingURL = "http://teambraison-dot.jit.su/"
    var delegate: DotHTTPRequestDelegate!
    
    init()
    {
        
    }

    
    func startRequest(relativeURL: String, parameters: Dictionary<String, AnyObject>) {
        var request = HTTPTask()
        request.GET(developmentURL + relativeURL, parameters: parameters, success: {(response: HTTPResponse) in
            println("response: \(response.text())")
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error) response: \(response?.text())")
        })
    }
    
    func startRequest(relativeURL: String) {
        let url = NSURL(string:developmentURL + relativeURL)
        var request = HTTPTask()
        request.GET(developmentURL + relativeURL, parameters:nil,  success: {(response: HTTPResponse) in
            var keyData:NSData = response.responseObject! as NSData
            var stringData = NSString(data: keyData, encoding: NSUTF8StringEncoding)
            var jsonObject: NSDictionary = NSJSONSerialization.JSONObjectWithData(keyData, options: NSJSONReadingOptions.MutableLeaves, error: nil) as NSDictionary
            self.didFinishRequest(jsonObject)
            
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error) response: \(response?.text())")
        })
    }
    
    func didFinishRequest(response: NSDictionary)
    {
        delegate.DotHTTPRequestDidReceiveData(response)
    }
    
}

class DotRequestLogin:DotHTTPRequest
{
    let api = "/api/login"
    
    func startRequest(relativeURL: String, ToRequestLogin parameters: NSDictionary) {
        var userName: AnyObject = parameters["username"]! as AnyObject
        var passWord: AnyObject = parameters["pass"]! as AnyObject
        var loginParameters: Dictionary<String, AnyObject> = ["user": userName, "pass":passWord] as Dictionary<String, AnyObject>
        self.startRequest(api, parameters: loginParameters)
    }
}

class DotRequestAllUsers:DotHTTPRequest
{
    let api = "/api/allusers"
    
    func startRequest() {
        self.startRequest(api)
    }
}


