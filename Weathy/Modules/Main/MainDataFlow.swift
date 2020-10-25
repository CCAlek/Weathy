//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

enum Main {
    
    // MARK: Получение местоположения пользователя
    enum GetUserLocation {
        struct Request {
        }

        struct Response {
            let result: MapLocationRequestResult
        }

        struct ViewModel {
            let state: MapViewState
        }
    }

    enum MapLocationRequestResult {
        case success(UserLocationCoordinateModel)
        case failure
        case permissionError
        case wait
    }
    
    enum MapViewState {
        case start
        case result(UserLocationCoordinateModel)
        case failure
        case permissionError
        case wait
    }
    
    // MARK: Получение данных о погоде
    enum FetchWeather {
        struct Request {
            let location: UserLocationCoordinateModel
        }
        
        struct Response {
            let result: RequestResult<WeatherModel>
        }
        
        struct ViewModel {
            let state: WeatherState
        }
    }
    
    enum WeatherState {
        case result(MainViewModel)
        case failure(String)
    }
    
    // MARK: Переход к экрану подробной информации о погоде
    enum NavigateToWeather {
        struct Request {
        }
        
        struct Response {
            let result: WeatherModel
        }
        
        struct ViewModel {
            let result: WeatherViewModel
        }
    }
}
