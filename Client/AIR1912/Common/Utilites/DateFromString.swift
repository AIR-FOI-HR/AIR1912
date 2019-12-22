//
//  DateFromString.swift
//  AIR1912
//
//  Created by Leo Leljak on 22/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation

class DateFromString{
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
}

