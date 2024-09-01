//
//  Reminder.swift
//  Today
//
//  Created by Zack Williams on 15/08/2024.
//

import Foundation

struct Reminder: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false

}

extension [Reminder] {
    func indexOfReminder(withID id: Reminder.ID) -> Self.Index {
        guard let index = firstIndex(where: {$0.id == id}) else {
            fatalError()
        }
        
        return index
    }
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
        ),
        Reminder(
            title: "Bake Banana Bread",
            dueDate: Date().addingTimeInterval(1000000),
            notes: "Include blackberries",
            isComplete: true
        )
    ]
}
#endif
