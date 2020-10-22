//
//  MainViewMapViewDelegate.swift
//  Weathy
//
//  Created by Семен Семенов on 22.10.2020.
//

import MapKit

class MainViewMapViewDelegate: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("mapView center: \(mapView.centerCoordinate)")
    }
}
