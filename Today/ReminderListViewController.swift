//

//  ViewController.swift
//  Today
//
//  Created by Zack Williams on 15/08/2024.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration {
            (
                cell: UICollectionViewListCell,
                IndexPath: IndexPath,
                itemIdentifier: String
            ) in
            
            let reminder = Reminder.sampleData[IndexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            
            contentConfiguration.text = reminder.title
            cell.contentConfiguration = contentConfiguration
        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (
                collectionView: UICollectionView,
                indexPath: IndexPath,
                itemIdentifier: String
            ) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        
        // snapshot.appendItems(Reminder.sampleData.map {$0.title})
        var reminderTitles = [String]()
        for reminder in Reminder.sampleData {
            reminderTitles.append(reminder.title)
        }
        snapshot.appendItems(reminderTitles)
        
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(
            appearance: .grouped
        )
        
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

