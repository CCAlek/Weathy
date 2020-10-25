//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

import CoreLocation

protocol MainBusinessLogic {

    // Запрос на получение местоположения пользователя
    func getUserLocation(request: Main.GetUserLocation.Request)
    
    // Запрос на получение данных о погоде
    func fetchWeather(request: Main.FetchWeather.Request)
    
    // Получение подробной информации о погоде для перехода на экран погоды
    func getWeather(request: Main.NavigateToWeather.Request)
}

/// Класс для описания бизнес-логики модуля Main
class MainInteractor: MainBusinessLogic {

    let presenter: MainPresentationLogic
    let provider: WeatherProviderProtocol
    var mapLocationService: MapLocationServiceProtocol

    init(presenter: MainPresentationLogic,
         provider: WeatherProviderProtocol = WeatherProvider(),
         mapLocationService: MapLocationServiceProtocol = MapLocationService()) {
        self.presenter = presenter
        self.provider = provider
        self.mapLocationService = mapLocationService
        self.mapLocationService.locationServiceDelegate = self
    }
    
    // MARK: Запрос на получение местоположения пользователя
    func getUserLocation(request: Main.GetUserLocation.Request) {
        mapLocationService.permissionRequest()
        mapLocationService.start()
        
        let result: Main.MapLocationRequestResult
        switch mapLocationService.authorizationStatus() {
        case .denied, .restricted:
            result = .permissionError
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = mapLocationService.getUserLocation() else { return }
            result = .success(UserLocationCoordinateModel(
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
    
    // MARK: Запрос на получение данных о погоде
    func fetchWeather(request: Main.FetchWeather.Request) {
        provider.fetchWeather(location: request.location) { [weak self] result in
            print("fetch weather result: \(result)")
            guard let strongSelf = self else { return }
            switch result {
            case let .success(result):
                let response = Main.FetchWeather.Response(result: .success(result))
                strongSelf.presenter.presentWeather(response: response)
            case let .failure(error):
                let response = Main.FetchWeather.Response(result: .failure(error))
                strongSelf.presenter.presentWeather(response: response)
            }
        }
    }
    
    // MARK: Получение подробной информации о погоде для перехода на экран погоды
    func getWeather(request: Main.NavigateToWeather.Request) {
        guard let result = provider.getWeather() else { return }
        let response = Main.NavigateToWeather.Response(result: result)
        presenter.navigateToWeather(response: response)
    }
}

extension MainInteractor: MapLocationServiceDelegate {
    func didUpdateLocations(_ locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let result: Main.MapLocationRequestResult
        result = .success(UserLocationCoordinateModel(
                            latitude: location.coordinate.latitude,
                            longitude: location.coordinate.longitude))
        presenter.presentUserLocation(response: Main.GetUserLocation.Response(result: result))
    }
}
