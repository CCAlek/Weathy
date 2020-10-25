//
//  Created by Semen Semenov on 21/10/2020.
//

protocol WeatherServiceProtocol {

    // Запрос получения данных о погоде
    // https://openweathermap.org/current
    func fetchWeather(units: WeatherUnits, location: UserLocationCoordinateModel, completion: @escaping (RequestResult<WeatherModel>) -> Void)
}

/// Получает данные для модуля Main
class WeatherService: WeatherServiceProtocol {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    // MARK: Запрос получения данных о погоде
    // https://openweathermap.org/current
    func fetchWeather(units: WeatherUnits, location: UserLocationCoordinateModel, completion: @escaping (RequestResult<WeatherModel>) -> Void) {
        let url = "\(WeatherMapEndpoints.weather)?lat=\(location.latitude)&lon=\(location.longitude)&lang=ru&units=\(units)&appid=\(WeatherMapConstants.apiKey)"
        apiClient.stop()
        apiClient.start(url: url, responseModel: WeatherModel.self) { result in
            completion(result)
        }
        
    }
}
