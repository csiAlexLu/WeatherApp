//
//  LocationInfoViewModel.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/31/23.
//

import Foundation
import Combine

struct LocationInfoUIModel: Equatable {
    let city: String
    let country: String
    let time: String
    let date: String
}

class LocationInfoViewModel {
    @Published private(set) var uiModel: LocationInfoUIModel?
    private var weather: Weather?
    private var subscriptions: Set<AnyCancellable> = []
    private var cancellableTimer: Cancellable?

    deinit {
        cancellableTimer?.cancel()
    }

    private func buildUIModels(_ location: Location) {

        let date = Date(timeIntervalSince1970: TimeInterval(location.localtimeEpoch))
        let timeFormatter = Formatter.timeFormatter
        let dateFormatter = Formatter.dateFormatter
        timeFormatter.timeZone = TimeZone(identifier: location.timeZoneID)
        dateFormatter.timeZone = TimeZone(identifier: location.timeZoneID)
        let localTime = timeFormatter.string(from: date)
        let localDate = dateFormatter.string(from: date)

        uiModel = LocationInfoUIModel(city: location.name, country: location.country, time: localTime, date: localDate)
    }

    var elapsedTime = 0
    private func startTimer() {
        cancellableTimer?.cancel()
        cancellableTimer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.uiModel = self.buildUIModels(self.weather?.location)
            }
    }

    func setWeather(_ weather: Weather?) {
        self.weather = weather
        uiModel = buildUIModels(weather?.location)

        if uiModel != nil {
            startTimer()
        }
    }

    private func buildUIModels(_ location: Location?) -> LocationInfoUIModel? {
        guard let location else {
            return nil
        }
        let date = Date(timeIntervalSince1970: TimeInterval(location.localtimeEpoch + elapsedTime))

        let timeFormatter = Formatter.timeFormatter
        timeFormatter.timeZone = TimeZone(identifier: location.timeZoneID)
        let localTime = timeFormatter.string(from: date)

        let dateFormatter = Formatter.dateFormatter
        dateFormatter.timeZone = TimeZone(identifier: location.timeZoneID)
        let localDate = dateFormatter.string(from: date)

        elapsedTime += 1

        return LocationInfoUIModel(city: location.name, country: location.country, time: localTime, date: localDate)
    }
}
