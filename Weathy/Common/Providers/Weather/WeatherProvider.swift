//
//  Created by Semen Semenov on 21/10/2020.
//

protocol WeatherProviderProtocol {

    // Запрос получения данных о погоде
    func fetchWeather(location: UserLocationCoordinateModel, completion: @escaping (RequestResult<WeatherModel>) -> Void)
    
    // Получение данных о погоде
    func getWeather() -> WeatherModel?
}

/// Отвечает за получение данных модуля Main
struct WeatherProvider: WeatherProviderProtocol {

    let service: WeatherServiceProtocol

    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }

    // MARK: Запрос получения данных о погоде
    func fetchWeather(location: UserLocationCoordinateModel, completion: @escaping (RequestResult<WeatherModel>) -> Void) {
        service.fetchWeather(units: .metric, location: location) { result in
            if case let .success(weather) = result {
                WeatherDataStore.weather = weather
            }
            completion(result)
        }
    }
    
    // MARK: Получение данных о погоде
    func getWeather() -> WeatherModel? {
        return WeatherDataStore.weather
    }
}
