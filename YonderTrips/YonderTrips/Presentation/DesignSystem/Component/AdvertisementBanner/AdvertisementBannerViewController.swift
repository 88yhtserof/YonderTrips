//
//  AdvertisementBannerViewController.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/11/25.
//

import UIKit
import SwiftUI

final class AdvertisementBannerViewController: UIViewController {
    
    private var list: [String]
    private var onPageChange: ((Int) async -> Void)?
    
    private var dataSource: DataSource!
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    init(list: [String], onPageChange: ((Int) -> Void)? = nil) {
        self.list = list
        self.onPageChange = onPageChange
        
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
    
    func updateList(with list: [String]) {
        
        self.list = list
        updateSnapshot()
    }
}

//MARK: - Configuration
private extension AdvertisementBannerViewController {
    
    func configureView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
    }
    
    func configureHierachy() {
        view.addSubview(collectionView)
    }
    
    func configureConstraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - CollectionView Layout
private extension AdvertisementBannerViewController {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

//MARK: - Type
extension AdvertisementBannerViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: CaseIterable {
        case newActivity
    }
    
    struct Item: Hashable, Identifiable {
        let id = UUID()
        let item: String
    }
}

//MARK: - CollectionView DataSource
private extension AdvertisementBannerViewController {
    
    func configureCollectionViewDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellResitrationHandler)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier.item)
        })
        
        updateSnapshot()
        collectionView.dataSource = dataSource
    }
    
    func cellResitrationHandler(cell: UICollectionViewCell, indexPath: IndexPath, item: String) {
        
        cell.contentConfiguration = UIHostingConfiguration {
            AdvertisementBannerCellView(item: item)
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

//MARK: - CollectionView Delegate
extension AdvertisementBannerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        Task {
            await onPageChange?(indexPath.item)
        }
    }
}
