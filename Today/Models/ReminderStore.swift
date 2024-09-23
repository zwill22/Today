//
//  ReminderStore.swift
//  Today
//
//  Created by Zack Williams on 23/09/2024.
//

import EventKit
import Foundation

final class ReminderStore {
    static let shared = ReminderStore()
    
    private let ekStore = EKEventStore()
    
    var isAvailable: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .writeOnly
    }
}
