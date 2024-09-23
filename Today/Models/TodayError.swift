//
//  TodayError.swift
//  Today
//
//  Created by Zack Williams on 23/09/2024.
//

import Foundation

enum TodayError: LocalizedError {
    case accessDenied
    case failedReadingReminders
    case reminderHasNoDueDate
    
    var errorDescription: String? {
        switch self {
        case .accessDenied:
            return NSLocalizedString(
                "The app does not have permission to read reminders", comment: "access denied error description")
        case .failedReadingReminders:
            return NSLocalizedString("Failed to read reminders.", comment: "failed reading reminders error description")
        case .reminderHasNoDueDate:
            return NSLocalizedString("Reminder has no due date.", comment: "reminder has no due date error description")
        }
    }
}
