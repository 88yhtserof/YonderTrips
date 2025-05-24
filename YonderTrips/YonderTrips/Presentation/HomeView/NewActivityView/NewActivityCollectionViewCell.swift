//
//  NewActivityCollectionViewCell.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/24/25.
//

import UIKit

final class NewActivityCollectionViewCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
         imageView.image = nil
    }
    
    func configure(with value: String) {
        imageView.image = UIImage(named: value)
    }
    
    func configureView() {
        imageView.backgroundColor = .gray30
        imageView.contentMode = .scaleAspectFill
        contentView.clipsToBounds = true
        contentView.layer.cornerCurve = .continuous
        contentView.layer.cornerRadius = 8
    }
    
    func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureHierarchy() {
        contentView.addSubview(imageView)
    }
}
