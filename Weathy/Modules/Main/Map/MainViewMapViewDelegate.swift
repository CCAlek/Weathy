//
//  MainViewMapViewDelegate.swift
//  Weathy
//
//  Created by Семен Семенов on 22.10.2020.
//

import MapKit

class MainViewMapViewDelegate: NSObject, MKMapViewDelegate {
    
    weak var delegate: MainViewControllerDelegate?
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let location = UserLocationCoordinateModel(
            latitude: mapView.centerCoordinate.latitude,
            longitude: mapView.centerCoordinate.longitude)
        delegate?.didChangeLocationCenterMapView(location: location)
    }
}
