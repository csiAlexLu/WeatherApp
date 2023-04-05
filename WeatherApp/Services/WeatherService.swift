//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import Foundation

class WeatherService {

    struct WeatherAPI {
      static let scheme = "https"
      static let host = "api.weatherapi.com"
      static let path = "/v1"
      static let key = "522db6a157a748e2996212343221502"
    }

    private func forecastComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = WeatherAPI.scheme
        components.host = WeatherAPI.host
        components.path = WeatherAPI.path + "/forecast.json"

        components.queryItems = [
            URLQueryItem(name: "key", value: WeatherAPI.key),
            URLQueryItem(name: "q", value: "london"),
            URLQueryItem(name: "days", value: "7"),
            URLQueryItem(name: "aqi", value: "no"),
            URLQueryItem(name: "alerts", value: "no")
        ]

        return components
    }

    func fetchWeather(completion: @escaping (Weather?) -> Void) {
        URLSession.shared.dataTask(with: forecastComponents().url!) { data, _, error in
            guard let data else { return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } catch let error as NSError {
                print("Failed to decode json, error: \(error)")
                completion(nil)
            }
        }
        .resume()
    }
}
