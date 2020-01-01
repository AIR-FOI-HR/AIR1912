//
//  FormatDate.swift
//  AIR1912
//
//  Created by Leo Leljak on 01/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation

class FormatDate {
     public static func getDateFromString(date: String?) -> NSDate? {
           if let date1 = date {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
               dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
               let date: NSDate? = dateFormatter.date(from: date1) as NSDate?
               return date!
           }
           return nil
       }
    
    public static func getStringFromDate(date: NSDate?) -> String? {
        if let date1 = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
            let stringDate = dateFormatter.string(from: date1 as Date)
           
            return stringDate
        }
        return nil
    }
}
