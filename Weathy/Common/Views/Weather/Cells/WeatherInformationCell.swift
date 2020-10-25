//
//  WeatherInformationCell.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import UIKit

class WeatherInformationCell: UITableViewCell {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor! = R.color.clearWhite()
        
        static let collectionSectionInsets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        static let collectionItemSize = CGSize(width: 104, height: 72)
        static let collectionLineSpacing: CGFloat = 16.0
        static let collectionVerticalMargin: CGFloat = 16.0
        static let collectionHeight: CGFloat = collectionItemSize.height + 2 * collectionVerticalMargin
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = ViewMetrics.collectionItemSize
        layout.sectionInset = ViewMetrics.collectionSectionInsets
        layout.minimumLineSpacing = ViewMetrics.collectionLineSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = ViewMetrics.backgroundColor
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var collectionDataSource = WeatherCollectionDataSource()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.dataSource = collectionDataSource
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: [WeatherInformationViewModel]) {
        collectionDataSource.representableViewModels = viewModel
        collectionView.reloadData()
    }
    
    private func setupLayout() {
        backgroundColor = ViewMetrics.backgroundColor
        selectionStyle = .none
        
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: ViewMetrics.collectionItemSize.height),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewMetrics.collectionVerticalMargin),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewMetrics.collectionVerticalMargin)
        ])
    }
}
