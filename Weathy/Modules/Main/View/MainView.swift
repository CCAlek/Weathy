//
//  Created by Semen Semenov on 21/10/2020.
//

import MapKit
import UIKit

class MainView: UIView {

    private enum ViewMetrics {
        static let backgroundColor = R.color.clearWhite()
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

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        backgroundColor = ViewMetrics.backgroundColor
        
        addSubview(mapView)
        
        mapView.frame = frame
    }
    
    func displayUserLocation(location: MainUserLocationCoordinateModel) {
        let location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 1500, longitudinalMeters: 1500)
        let region = self.mapView.regionThatFits(coordinateRegion)
        self.mapView.setRegion(region, animated: true)
    }
}
