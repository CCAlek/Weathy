//
//  MainMapLocationService.swift
//  Weathy
//
//  Created by Семен Семенов on 22.10.2020.
//

import CoreLocation

protocol MainMapLocationServiceProtocol {
    
    var locationServiceDelegate: MainMapLocationServiceDelegate? { get set }
    
    // Получение местоположения пользователя
    func getUserLocation() -> CLLocation?
    
    // Получение статуса разрешения местоположения пользователя
    func authorizationStatus() -> CLAuthorizationStatus
    
    // Запрос на разрешение использования местоположения
    func permissionRequest()
    
    // Запуск нахождения местоположения
    func start()
}

protocol MainMapLocationServiceDelegate: class {
    
    func didUpdateLocations(_ locations: [CLLocation])
}

class MainMapLocationService: NSObject, MainMapLocationServiceProtocol {
    
    weak var locationServiceDelegate: MainMapLocationServiceDelegate?
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    // MARK: Получение местоположения пользователя
    func getUserLocation() -> CLLocation? {
        return locationManager.location
    }
    
    // MARK: Получение статуса разрешения местоположения пользователя
    func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    // MARK: Запрос на разрешение использования местоположения
    func permissionRequest() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: Запуск нахождения местоположения
    func start() {
        setActiveMode(true)
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    private func setActiveMode(_ value: Bool) {
        if value {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.distanceFilter = 30
        } else {
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.distanceFilter = CLLocationDistanceMax
        }
    }
}

extension MainMapLocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationServiceDelegate?.didUpdateLocations(locations)
        print("Map service locations: \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Map service error: \(error)")
    }
}
