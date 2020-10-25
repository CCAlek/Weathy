//
//  WeatherTitleCell.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import UIKit

class WeatherTitleCell: UITableViewCell {
    
    enum ViewMetrics {
        static let backgroundColor = R.color.clearWhite()
        
        static let standartMargin: CGFloat = 16.0
        static let spacing: CGFloat = 4.0
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = R.color.dark()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = ViewMetrics.standartMargin
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 46, weight: .regular)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = R.color.dark()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = ViewMetrics.standartMargin
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = R.color.dark()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = R.color.dark()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: MainViewModel) {
        titleLabel.text = viewModel.title
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.description
        feelsLikeLabel.text = viewModel.feelsLike
        if let url = URL(string: viewModel.iconURL) {
            iconImageView.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground, .progressiveLoad], completed: nil)
        }
    }
    
    func setupLayer() {
        backgroundColor = ViewMetrics.backgroundColor
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainStackView)
        contentView.addSubview(labelStackView)
        mainStackView.addArrangedSubview(temperatureLabel)
        mainStackView.addArrangedSubview(iconImageView)
        labelStackView.addArrangedSubview(descriptionLabel)
        labelStackView.addArrangedSubview(feelsLikeLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewMetrics.standartMargin),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewMetrics.standartMargin),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewMetrics.standartMargin),
            
            mainStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2 * ViewMetrics.standartMargin),
            mainStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            labelStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: ViewMetrics.spacing),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewMetrics.standartMargin),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewMetrics.standartMargin),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ViewMetrics.spacing)
        ])
    }
}
