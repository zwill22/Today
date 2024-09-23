//
//  ReminderEKReminder.swift
//  Today
//
//  Created by Zack Williams on 23/09/2024.
//

import EventKit
import Foundation

extension Reminder {
    init(with ekReminder: EKReminder) throws {
        guard let dueDate = ekReminder.alarms?.first?.absoluteDate else {
            throw TodayError.reminderHasNoDueDate
        }
        id = ekReminder.calendarItemIdentifier
        title = ekReminder.title
        self.dueDate = dueDate
        
        notes = ekReminder.notes
        isComplete = ekReminder.isCompleted
    }
}
