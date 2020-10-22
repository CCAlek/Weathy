//
//  WeatherModel.swift
//  Weathy
//
//  Created by Семен Семенов on 22.10.2020.
//

import Foundation

struct WeatherModel: Decodable {
    let coordinate: WeatherCoordinateModel
    let weather: [WeatherWeatherModel]
    let base: String
    let main: WeatherMainModel
    let visibility: Int
    let wind: WeatherWindModel
    let clouds: WeatherCloudsModel
    let dt: Int
    let sys: WeatherSysModel
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case timezone
        case id
        case name
        case cod
    }
}

struct WeatherCoordinateModel: Decodable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lon"
        case longitude = "lat"
    }
}

struct WeatherWeatherModel: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherMainModel: Decodable {
    let temperature: Double
    let feelsLike: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let pressure: Int
    let humidity: Int
}

struct WeatherWindModel: Decodable {
    let speed: Int
    let deg: Int
}

struct WeatherCloudsModel: Decodable {
    let all: Int
}

struct WeatherSysModel: Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
