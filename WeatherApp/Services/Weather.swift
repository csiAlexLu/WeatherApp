//
//  Forecast.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/31/23.
//

import Foundation

struct Weather: Codable {
    let location: Location
    let forecast: Forecast
}

struct Location: Codable {
    let name, country: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, country
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

struct Forecast: Codable {
    let forecastday: [Forecastday]
}

struct Forecastday: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day
    }
}

struct Day: Codable {
    let maxtempC, maxtempF, mintempC, mintempF: Double
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
    }
}
