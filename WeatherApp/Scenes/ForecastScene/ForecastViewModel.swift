//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit

class ForecastViewModel {
    private(set) var forecast = [WeatherCellUIModel]()

    init() {
        prepareMockForecast()
    }

    private func prepareMockForecast() {
        for _ in 1...10 {
            let model = WeatherCellUIModel(maxMinTemp: "max: 27°C\nmin: 19°C", date: "23, march, 2023", image: UIImage(named: "placeholder")!)
            forecast.append(model)
        }
    }
}
