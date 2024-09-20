//
//  ReminderListStyle.swift
//  Today
//
//  Created by Zack Williams on 20/09/2024.
//

import Foundation

enum ReminderListStyle: Int {
    case today
    case future
    case all

    func shouldInclude(date: Date) -> Bool {
        let isInToday = Locale.current.calendar.isDateInToday(date)
        switch self {
        case .today:
            return isInToday
        case .future:
            return (date > Date.now) && !isInToday
        case .all:
            return true
        }
    }
}
