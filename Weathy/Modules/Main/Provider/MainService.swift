//
//  Created by Semen Semenov on 21/10/2020.
//

protocol MainServiceProtocol {

    // Запрос получения данных о погоде
    // https://openweathermap.org/current
    func fetchWeather(location: UserLocationCoordinateModel, completion: @escaping (RequestResult<WeatherModel>) -> Void)
}

/// Получает данные для модуля Main
class MainService: MainServiceProtocol {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    // MARK: Запрос получения данных о погоде
    // https://openweathermap.org/current
    func fetchWeather(location: UserLocationCoordinateModel, completion: @escaping (RequestResult<WeatherModel>) -> Void) {
        let url = "\(WeatherMapEndpoints.weather)?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(WeatherMapConstants.apiKey)"
        apiClient.start(url: url, responseModel: WeatherModel.self) { result in
            completion(result)
        }
        
    }
}
