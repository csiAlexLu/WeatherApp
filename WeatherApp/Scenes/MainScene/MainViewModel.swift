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

    private var weatherService: WeatherServiceProtocol
    private var subscriptions: Set<AnyCancellable> = []

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        addObservers()
    }

    private func addObservers() {
        $searchText
            .debounce(for: .seconds(Constants.debounceDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] inputText in
                guard let self else { return }
                guard !inputText.isEmpty else {
                    self.weather = nil
                    return
                }
                self.fetchWeather(for: inputText)
            }
            .store(in: &subscriptions)
    }

    private func fetchWeather(for city: String) {
        weatherService.fetchWeather(for: city) { [weak self] weather, error  in
            self?.weather = weather
        }
    }
}
