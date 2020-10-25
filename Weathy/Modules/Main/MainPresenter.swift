//
//  Модуль главного экрана
//  Created by Semen Semenov on 21/10/2020.
//

import UIKit

protocol MainPresentationLogic {

    // Показ местоположения пользователя
    func presentUserLocation(response: Main.GetUserLocation.Response)
    
    // Показ данных о погоде
    func presentWeather(response: Main.FetchWeather.Response)
    
    // Переход к экрану подробной информации о погоде
    func navigateToWeather(response: Main.NavigateToWeather.Response)
}

/// Отвечает за отображение данных модуля Main
class MainPresenter: MainPresentationLogic {

    weak var viewController: MainDisplayLogic?

    // MARK: Показ местоположения пользователя
    func presentUserLocation(response: Main.GetUserLocation.Response) {
        var viewModel: Main.GetUserLocation.ViewModel
        
        switch response.result {
        case .failure:
            viewModel = Main.GetUserLocation.ViewModel(state: .failure)
        case let .success(result):
            viewModel = Main.GetUserLocation.ViewModel(state: .result(result))
        case .permissionError:
            viewModel = Main.GetUserLocation.ViewModel(state: .permissionError)
        case .wait:
            viewModel = Main.GetUserLocation.ViewModel(state: .wait)
        }
        
        viewController?.displayUserLocation(viewModel: viewModel)
    }
    
    // MARK: Показ данных о погоде
    func presentWeather(response: Main.FetchWeather.Response) {
        var viewModel: Main.FetchWeather.ViewModel

        switch response.result {
        case let .success(result):
            let weatherViewModel = getWeatherViewModel(weather: result)
            viewModel = Main.FetchWeather.ViewModel(state: .result(weatherViewModel))
        case let .failure(error):
            viewModel = Main.FetchWeather.ViewModel(state: .failure(error))
        }
        
        viewController?.displayWeather(viewModel: viewModel)
    }
    
    // MARK: Переход к экрану подробной информации о погоде
    func navigateToWeather(response: Main.NavigateToWeather.Response) {
        let weatherViewModel = getWeatherScreenViewModel(weather: response.result)
        let viewModel = Main.NavigateToWeather.ViewModel(result: weatherViewModel)
        viewController?.displayWeatherScreen(viewModel: viewModel)
    }
}

extension MainPresenter {
    // MARK: Получение модели отображения данных о погоде
    private func getWeatherViewModel(weather: WeatherModel) -> MainViewModel {
        var iconURL: String
        if let icon = weather.weather.first?.icon {
            iconURL = "\(WeatherMapEndpoints.icon)/\(icon)@2x.png"
        } else {
            iconURL = ""
        }
        
        let title = weather.name.isEmpty ? "-" : weather.name
        let temperature = removeDecimal(number: weather.main.temperature)
        let feelsLike = removeDecimal(number: weather.main.feelsLike)
        
        let viewModel = MainViewModel(
            title: R.string.localizable.mainTitleViewModel(title),
            temperature: R.string.localizable.mainTemperature(temperature),
            iconURL: iconURL,
            description: weather.weather.first?.description ?? "",
            feelsLike: R.string.localizable.mainFeelsLike(feelsLike))
        return viewModel
    }
    
    private func removeDecimal(number: Double) -> String {
        let text = number.description
        if let index = text.range(of: ".")?.lowerBound {
            return String(text.prefix(upTo: index))
        }
        return text
    }
    
    // MARK: Получение модели отображения подробной информации о погоде
    private func getWeatherScreenViewModel(weather: WeatherModel) -> WeatherViewModel {
        let viewModel = WeatherViewModel(rows: [
            .title(getWeatherViewModel(weather: weather))
        ])
        return viewModel
    }
}
