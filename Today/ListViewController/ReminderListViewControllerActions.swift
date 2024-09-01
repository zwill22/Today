//
//  ReminderListViewControllerActions.swift
//  Today
//
//  Created by Zack Williams on 01/09/2024.
//

import UIKit

extension ReminderListViewController {
    
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else {return}
        completeReminder(withID: id)
    }
}
