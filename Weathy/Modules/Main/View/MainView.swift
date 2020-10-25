//
//  Created by Semen Semenov on 21/10/2020.
//

import MapKit
import SDWebImage
import UIKit

class MainView: UIView {

    private enum ViewMetrics {
        static let backgroundColor = R.color.clearWhite()
        
        static let arrowImageViewSize: CGSize = CGSize(width: 48.0, height: 48.0)
        
        static let standartMargin: CGFloat = 16
        static let spacing: CGFloat = 4
        
        static let iconImageViewSize: CGSize = CGSize(width: 24.0, height: 24.0)
    }

    private var mainViewMapViewDelegate: MainViewMapViewDelegate = MainViewMapViewDelegate()

    private let tilesOverlay: MKTileOverlay = {
        let overlay = MKTileOverlay()
        return overlay
    }()

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsCompass = false
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsBuildings = false
        mapView.showsTraffic = false
        mapView.delegate = mainViewMapViewDelegate
        mapView.insertOverlay(tilesOverlay, at: 15, level: .aboveRoads)
        mapView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return mapView
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mainCenterArrow()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var weatherView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.shadowColor = R.color.dark()?.withAlphaComponent(0.05).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 12
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.backgroundColor = ViewMetrics.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = R.color.dark()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 46, weight: .regular)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = R.color.dark()
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
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = R.color.dark()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = R.color.dark()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(frame: CGRect = CGRect.zero,
         delegate: MainViewControllerDelegate) {
        mainViewMapViewDelegate.delegate = delegate
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
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

    func setupLayout() {
        backgroundColor = ViewMetrics.backgroundColor
        mapView.backgroundColor = ViewMetrics.backgroundColor
        
        addSubview(mapView)
        addSubview(arrowImageView)
        addSubview(weatherView)
        weatherView.addSubview(titleLabel)
        weatherView.addSubview(temperatureLabel)
        weatherView.addSubview(iconImageView)
        weatherView.addSubview(descriptionLabel)
        weatherView.addSubview(feelsLikeLabel)
        
        mapView.frame = frame
        
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -ViewMetrics.arrowImageViewSize.height / 2),
            arrowImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: ViewMetrics.arrowImageViewSize.height),
            arrowImageView.widthAnchor.constraint(equalToConstant: ViewMetrics.arrowImageViewSize.width)
        ])
        
        NSLayoutConstraint.activate([
            weatherView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewMetrics.standartMargin),
            weatherView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -ViewMetrics.standartMargin),
            weatherView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -ViewMetrics.standartMargin),
            weatherView.heightAnchor.constraint(equalToConstant: 168),
            
            titleLabel.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: ViewMetrics.standartMargin),
            titleLabel.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor, constant: ViewMetrics.standartMargin),
            titleLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -ViewMetrics.spacing),
            
            temperatureLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewMetrics.spacing),
            temperatureLabel.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor, constant: ViewMetrics.standartMargin),
            
            iconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -ViewMetrics.standartMargin),
            iconImageView.heightAnchor.constraint(equalToConstant: ViewMetrics.iconImageViewSize.height),
            iconImageView.widthAnchor.constraint(equalToConstant: ViewMetrics.iconImageViewSize.width),
            
            descriptionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: ViewMetrics.spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: ViewMetrics.spacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -ViewMetrics.standartMargin),

            feelsLikeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: ViewMetrics.spacing),
            feelsLikeLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: ViewMetrics.spacing),
            feelsLikeLabel.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -ViewMetrics.standartMargin)
        ])
    }
    
    func displayUserLocation(location: UserLocationCoordinateModel) {
        let location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 1500, longitudinalMeters: 1500)
        let region = self.mapView.regionThatFits(coordinateRegion)
        self.mapView.setRegion(region, animated: true)
    }
}
