//
//  NewActivityViewController.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/24/25.
//

import UIKit
import SwiftUI

final class NewActivityViewController: UIViewController {
    
    private var list: [Activity]
    
    private var dataSource: DataSource!
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    init(list: [Activity]) {
        self.list = list
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureConstraints()
        configureView()
        configureCollectionViewDataSource()
    }
    
    func updateList(with list: [Activity]) {
        
        self.list = list
        updateSnapshot()
    }
}

//MARK: - Configuration
private extension NewActivityViewController {
    
    func configureView() {
        collectionView.backgroundColor = .clear
    }
    
    func configureHierachy() {
        view.addSubview(collectionView)
    }
    
    func configureConstraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - CollectionView Layout
private extension NewActivityViewController {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = -20
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            let containerWidth = environment.container.contentSize.width
            let centerX = offset.x + containerWidth / 2
            
            for item in items {
                let itemCenterX = item.center.x
                let distanceFromCenter = abs(centerX - itemCenterX)
                let maxDistance = containerWidth / 2
                
                let scale = max(0.8, 1.0 - (distanceFromCenter / maxDistance) * 0.1)
                
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

//MARK: - Type
extension NewActivityViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: CaseIterable {
        case newActivity
    }
    
    struct Item: Hashable, Identifiable {
        let id = UUID()
        let item: Activity
    }
}

//MARK: - CollectionView DataSource
private extension NewActivityViewController {
    
    func configureCollectionViewDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellResitrationHandler)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier.item)
        })
        
        updateSnapshot()
        collectionView.dataSource = dataSource
    }
    
    func cellResitrationHandler(cell: UICollectionViewCell, indexPath: IndexPath, item: Activity) {
        
        cell.contentConfiguration = UIHostingConfiguration {
            NewActivityCellView(item: item)
        }
    }
    
    func updateSnapshot() {
        let items = list.map{ Item(item: $0) }
        
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}




