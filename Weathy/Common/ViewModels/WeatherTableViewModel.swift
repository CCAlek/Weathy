//
//  WeatherViewModel.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import Foundation

struct WeatherTableViewModel {
    let rows: [WeatherRowType]
    
    init(rows: [WeatherRowType] = []) {
        self.rows = rows
    }
}

enum WeatherRowType {
    case title(WeatherViewModel)
    case information([WeatherInformationViewModel])
}

struct WeatherViewModel {
    let title: String
    let temperature: String
    let iconURL: String
    let description: String
    let feelsLike: String
}

struct WeatherInformationViewModel {
    let title: String
    let description: String
}
