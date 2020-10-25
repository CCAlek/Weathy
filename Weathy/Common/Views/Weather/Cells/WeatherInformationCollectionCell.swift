//
//  WeatherInformationCollectionCell.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import UIKit

class WeatherInformationCollectionCell: UICollectionViewCell {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor! = R.color.lightGray()
        static let radius: CGFloat = 16.0
        
        static let titleLabelFont: UIFont = .systemFont(ofSize: 12.0, weight: .semibold)
        static let titleLabelColor: UIColor! = R.color.gray()
        
        static let descriptionLabelFont: UIFont = .systemFont(ofSize: 14.0, weight: .semibold)
        static let descriptionLabelColor: UIColor! = R.color.dark()
        
        static let titleLabelTopMargin:  CGFloat = 16.0
        static let labelMargin: CGFloat = 8.0
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = ViewMetrics.titleLabelFont
        label.textColor = ViewMetrics.titleLabelColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = ViewMetrics.descriptionLabelFont
        label.textColor = ViewMetrics.descriptionLabelColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: WeatherInformationViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
    
    private func setupLayout() {
        backgroundColor = ViewMetrics.backgroundColor
        isSelected = false
        layer.cornerRadius = ViewMetrics.radius
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewMetrics.titleLabelTopMargin),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewMetrics.labelMargin),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewMetrics.labelMargin),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewMetrics.labelMargin),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewMetrics.labelMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewMetrics.labelMargin)
        ])
    }
}
