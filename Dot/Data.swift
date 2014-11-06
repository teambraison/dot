//
//  Data.swift
//  Dot
//
//  Created by Titus Cheng on 11/4/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation

class Data
{
    class func time() -> String
    {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        var hourString: String
        var minuteString: String
        var setting: String
        
        if(components.hour > 12) {
            hourString = String(components.hour - 12)
            setting = " p.m"
        } else {
            hourString = String(components.hour)
            setting = " a.m"
        }
        if (components.minute >= 0 && components.minute <= 9) {
            minuteString = "0" + String(components.minute)
        } else {
            minuteString = String(components.minute)
        }
        return "  " + hourString + ":" + minuteString + setting
        
    }
}
