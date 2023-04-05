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
    let name: String
    let country: String
    let localtimeEpoch: Int
    let localtime: String
    let timeZoneID: String

    enum CodingKeys: String, CodingKey {
        case name
        case country
        case localtimeEpoch = "localtime_epoch"
        case localtime
        case timeZoneID = "tz_id"
    }
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
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
    let maxtempC: Double
    let maxtempF: Double
    let mintempC: Double
    let mintempF: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case condition
    }
}

struct Condition: Codable {
    let icon: String
}
