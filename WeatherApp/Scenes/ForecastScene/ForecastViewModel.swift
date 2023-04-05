//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit
import Combine

class ForecastViewModel {

    @Published private(set) var forecast = [WeatherCellUIModel]()

    func setWeather(_ weather: Weather?) {

        guard let weather else {
            forecast.removeAll()
            return
        }

        let dateFormatter = Formatter.dateFormatter
        dateFormatter.timeZone = TimeZone(identifier: weather.location.timeZoneID)

        var forecastModels = [WeatherCellUIModel]()
        weather.forecast.forecastday.forEach { day in

            let date = Date(timeIntervalSince1970: TimeInterval(day.dateEpoch))
            let localDate = dateFormatter.string(from: date)

            let temp = "max: \(day.day.maxtempC)°C\nmin: \(day.day.mintempC)°C"

            let icon = "https:"+day.day.condition.icon
            let model = WeatherCellUIModel(maxMinTemp: temp, date: localDate, image: icon)
            forecastModels.append(model)
        }

        forecast = forecastModels
    }

}
