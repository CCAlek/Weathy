//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

import CoreLocation

protocol MainBusinessLogic {

    // Запрос на получение местоположения пользователя
    func getUserLocation(request: Main.GetUserLocation.Request)
}

/// Класс для описания бизнес-логики модуля Main
class MainInteractor: MainBusinessLogic {

    let presenter: MainPresentationLogic
    let provider: MainProviderProtocol
    var mapLocationService: MainMapLocationServiceProtocol

    init(presenter: MainPresentationLogic,
         provider: MainProviderProtocol = MainProvider(),
         mapLocationService: MainMapLocationServiceProtocol = MainMapLocationService()) {
        self.presenter = presenter
        self.provider = provider
        self.mapLocationService = mapLocationService
        self.mapLocationService.locationServiceDelegate = self
    }
    
    // MARK: Запрос на получение местоположения пользователя
    func getUserLocation(request: Main.GetUserLocation.Request) {
        mapLocationService.permissionRequest()
        mapLocationService.start()
        
        let result: Main.MainMapLocationRequestResult
        switch mapLocationService.authorizationStatus() {
        case .denied, .restricted:
            result = .permissionError
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = mapLocationService.getUserLocation() else { return }
            result = .success(MainUserLocationCoordinateModel(
                                latitude: location.coordinate.latitude,
                                longitude: location.coordinate.longitude))
        case .notDetermined:
            mapLocationService.permissionRequest()
            result = .wait
        default:
            result = .failure
        }
        presenter.presentUserLocation(response: Main.GetUserLocation.Response(result: result))
    }
}

extension MainInteractor: MainMapLocationServiceDelegate {
    func didUpdateLocations(_ locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let result: Main.MainMapLocationRequestResult
        result = .success(MainUserLocationCoordinateModel(
                            latitude: location.coordinate.latitude,
                            longitude: location.coordinate.longitude))
        presenter.presentUserLocation(response: Main.GetUserLocation.Response(result: result))
    }
}
