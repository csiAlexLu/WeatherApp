//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/31/23.
//

import Foundation
import Combine

class MainViewModel {

    enum Constants {
        static let debounceDelay = 1.5
    }

    @Published private(set) var weather: Weather?
    @Published var searchText: String = String()

    private var weatherService: WeatherService
    private var subscriptions: Set<AnyCancellable> = []

    init(weatherService: WeatherService) {
        self.weatherService = weatherService
        addObservers()
    }

    private func addObservers() {
        $searchText
            .debounce(for: .seconds(Constants.debounceDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] inputText in
                guard let self else { return }
                self.weatherService.fetchWeather(for: inputText) { weather in
                    self.weather = weather
                }
            }
            .store(in: &subscriptions)
    }
}
