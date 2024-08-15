//
//  Reminder.swift
//  Today
//
//  Created by Zack Williams on 15/08/2024.
//

import Foundation

struct Reminder {
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false

}

#if DEBUG
extension Reminder {
    static var sampleData = [
        Reminder(
            title: "Submit reimbursement report",
            dueDate: Date().addingTimeInterval(800),
            notes: "Don't forget about tax receipts"
        ),
        Reminder(
            title: "Code review",
            dueDate: Date().addingTimeInterval(14000),
            notes: "Check technical specs"
        ),
        Reminder(
            title: "Pick up new contracts",
            dueDate: Date().addingTimeInterval(24000),
            notes: "Optomitrist closes at 6:00PM"
        ),
        Reminder(
            title: "Do exercise",
            dueDate: Date().addingTimeInterval(1500),
            notes: "Week 6 Day 1 again"
        ),
        Reminder(
            title: "Cook chicken",
            dueDate: Date().addingTimeInterval(200),
            notes: "Marinade beforehand"
        )
    ]
}
#endif
