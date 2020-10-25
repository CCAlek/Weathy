//
//  WeatherMapEndpoints.swift
//  Weathy
//
//  Created by Семен Семенов on 22.10.2020.
//

import Foundation

struct WeatherMapEndpoints {
    // Получение данных о погоде по координатам
    // https://openweathermap.org/current
    static let weather = "\(BaseURL.openWeatherMap)/data/2.5/weather"
    
    // Получение иконки погоды
    static let icon = "https://openweathermap.org/img/wn"
}
