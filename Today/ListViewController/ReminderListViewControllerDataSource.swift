//
//  ReminderListViewControllerDataSource.swift
//  Today
//
//  Created by Zack Williams on 29/08/2024.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }
    
    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }
    
    private var reminderStore: ReminderStore {
        ReminderStore.shared
    }
    
    func updateSnapshot(reloading idsThatChanged: [Reminder.ID] = []) {
        let ids = idsThatChanged.filter {
            id in filteredReminders.contains(where: {$0.id == id})
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        
        snapshot.appendItems(filteredReminders.map {$0.id})
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
        headerView?.progress = progress
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        let reminder = reminder(withID: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
        cell.accessibilityValue = reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
        ]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    func reminder(withID id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withID: id)
        
        return reminders[index]
    }
    
    func updateReminder(_ reminder: Reminder) {
        do {
            try reminderStore.save(reminder)
            let index = reminders.indexOfReminder(withID: reminder.id)
            
            reminders[index] = reminder
        } catch TodayError.accessDenied {
            
        } catch {
            showError(error)
        }
    }
    
    func completeReminder(withID id: Reminder.ID) {
        var reminder = reminder(withID: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }
    
    func addReminder(_ reminder: Reminder) {
        var reminder = reminder
        do {
            let idFromStore = try reminderStore.save(reminder)
            reminder.id = idFromStore
            reminders.append(reminder)
        } catch TodayError.accessDenied {
            
        } catch {
            showError(error)
        }
    }
    
    func deleteReminder(withID id: Reminder.ID) {
        let index = reminders.indexOfReminder(withID: id)
        reminders.remove(at: index)
    
    }
    
    func prepareReminderStore() {
        Task {
            do {
                try await reminderStore.requestAccess()
                reminders = try await reminderStore.readAll()
                NotificationCenter.default.addObserver(
                    self, selector: #selector(eventStoreChanged(_:)), name: .EKEventStoreChanged, object: nil)
            } catch TodayError.accessDenied, TodayError.accessRestricted {
#if DEBUG
                reminders = Reminder.sampleData
#endif
            } catch {
                showError(error)
            }
            
            updateSnapshot()
        }
    }
    
    func reminderStoreChanged() {
        Task {
            reminders = try await reminderStore.readAll()
            updateSnapshot()
        }
    }
    
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completion", comment: "Reminder done accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(withID: reminder.id)
            
            return true
        }
        
        return action
    }
    
    func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill": "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        
        let highlightedSymbolName = reminder.isComplete ? "pencil.circle": "cross"
        let highlightedImage = UIImage(systemName: highlightedSymbolName, withConfiguration: symbolConfiguration)
        
        let button = ReminderDoneButton()
        button.id = reminder.id
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.setImage(highlightedImage, for: .highlighted)
        
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
