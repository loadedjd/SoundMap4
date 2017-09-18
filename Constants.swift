//
//  Constants.swift
//  SoundMap3
//
//  Created by Jared Williams on 7/29/17.
//  Copyright © 2017 Jared Williams. All rights reserved.
//

import Foundation
import UIKit



enum Sides {
    case left
    case right
}

extension String {
    func truncate(length: Int) -> String {
        return String(self.characters.prefix(length))
    }
}

struct timeDate {
    
    
    static var date = Date()
    static var calendar = Calendar.current
    static var hour = calendar.component(.hour, from: date)
    static var minute = calendar.component(.minute, from: date)
    static var weekDay = String(calendar.component(.weekday, from: date))
    static var month = String(calendar.component(.month, from: date))
    static var year = calendar.component(.year, from: date)
    static var day = calendar.component(.day, from: date)
    static var second = calendar.component(.second, from: date)
    static var timeZone = TimeZone.current.abbreviation()!
    static var timeStamp = "\( convert(weekdDay: weekDay as String)) \(convertMonth(month: month)) \(day) \(hour):\(minute):\(second) \(timeZone) \(year)" as String
    
    
    
    static func updateDate() {
         date = Date()
         calendar = Calendar.current
         hour = calendar.component(.hour, from: date)
         minute = calendar.component(.minute, from: date)
         weekDay = String(calendar.component(.weekday, from: date))
         month = String(calendar.component(.month, from: date))
         year = calendar.component(.year, from: date)
         day = calendar.component(.day, from: date)
         second = calendar.component(.second, from: date)
         timeZone = TimeZone.current.abbreviation()!
         timeStamp = "\( convert(weekdDay: weekDay as String)) \(convertMonth(month: month)) \(day) \(hour):\(minute):\(second) \(timeZone) \(year)" as String
    }
    
    
    static func convert(weekdDay: String) -> String {
        switch weekdDay {
        case "1":
            return "Sunday"
            
        case "2":
            return "Monday"
            
        case "3":
            return "Tuesday"
            
        case "4":
            return "Wednesday"
            
        case "5":
            return "Thursday"
            
        case "6":
            return "Friday"
            
        case "7":
            return "Saturday"
            
            
        default:
            return "Nil"
            
        }
        
    
    
    
    
}
    
    
static func convertMonth(month: String) -> String
    {
    switch month {
    
    
    case "1":
    return "January"
    
    case "2":
    return "February"
    
    case "3":
    return "March"
    
    case "4":
    return "April"
    
    case "5":
    return "May"
    
    case "6":
    return "June"
    
    case "7":
    return "July"
    
    case "8":
    return "August"
    
    case "9":
    return "September"
    
    case "10":
    return "October"
    
    case "11":
    return "November"
    
    case "12":
    return "December"
    
    default:
    return "nil"
    }
    }

    
    
    public enum Weekday: Int  {
        case Sunday = 1
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
        
        
    }
    
    
    public enum Months: Int {
        case January = 1
        case February
        case March
        case April
        case May
        case June
        case July
        case August
        case September
        case October
        case November
        case December
    }
}
    
    

