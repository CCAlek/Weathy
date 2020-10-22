//
//  Created by Semen Semenov on 21/10/2020.
//

protocol MainProviderProtocol {

    // Запрос получения данных о погоде
    func fetchWeather(location: UserLocationCoordinateModel, completion: @escaping (RequestResult<WeatherModel>) -> Void)
}

/// Отвечает за получение данных модуля Main
struct MainProvider: MainProviderProtocol {

    let dataStore: MainDataStore
    let service: MainServiceProtocol

    init(dataStore: MainDataStore = MainDataStore(),
         service: MainServiceProtocol = MainService()) {
        self.dataStore = dataStore
        self.service = service
    }

    // MARK: Запрос получения данных о погоде
    func fetchWeather(location: UserLocationCoordinateModel, completion: @escaping (RequestResult<WeatherModel>) -> Void) {
        service.fetchWeather(location: location) { result in
            completion(result)
        }
    }
}
