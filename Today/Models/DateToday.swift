//
//  DateToday.swift
//  Today
//
//  Created by Zack Williams on 29/08/2024.
//

import Foundation

extension Date {
    var dayTimeText : String {
        let timeText = formatted(date: .omitted, time: .shortened)
        if Locale.current.calendar.isDateInToday(self){
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
            return String(format: timeFormat, timeText)
        } else {
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateTimeFormat = NSLocalizedString("%@ at %@", comment: "Date and Time format string")
            
            return String(format: dateTimeFormat, dateText, timeText)
        }
    }
    
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Today due date description")
        } else {
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
