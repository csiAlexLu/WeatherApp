//
//  ForecastViewModelTests.swift
//  WeatherAppTests
//
//  Created by Alexander Luchenok on 4/4/23.
//

import XCTest
@testable import WeatherApp

final class ForecastViewModelTests: XCTestCase, JsonLoadable {

    var viewModel: ForecastViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()

        viewModel = ForecastViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func test3daysWeather() {
        let bostonWeather = loadMockWeather(fileName: "bostonWeatherData")
        viewModel.setWeather(bostonWeather)

        let firstDay = WeatherCellUIModel(maxMinTemp: "max: 9.0°C\nmin: 6.8°C",
                                          date: "Apr 3, 2023",
                                          image: "https://cdn.weatherapi.com/weather/64x64/day/122.png")

        let secondDay = WeatherCellUIModel(maxMinTemp: "max: 4.7°C\nmin: 3.3°C",
                                          date: "Apr 4, 2023",
                                          image: "https://cdn.weatherapi.com/weather/64x64/day/176.png")

        let thirdDay = WeatherCellUIModel(maxMinTemp: "max: 22.1°C\nmin: 4.3°C",
                                          date: "Apr 5, 2023",
                                          image: "https://cdn.weatherapi.com/weather/64x64/day/302.png")

        let uiModels = [firstDay, secondDay, thirdDay]

        XCTAssertEqual(uiModels, viewModel.forecast)
    }

    func test2daysWeather() {
        let warsawWeather = loadMockWeather(fileName: "warsawWeatherData")
        viewModel.setWeather(warsawWeather)

        let firstDay = WeatherCellUIModel(maxMinTemp: "max: 5.4°C\nmin: -1.2°C",
                                          date: "Apr 4, 2023",
                                          image: "https://cdn.weatherapi.com/weather/64x64/day/122.png")

        let secondDay = WeatherCellUIModel(maxMinTemp: "max: 6.7°C\nmin: -1.1°C",
                                          date: "Apr 5, 2023",
                                          image: "https://cdn.weatherapi.com/weather/64x64/day/116.png")

        let uiModels = [firstDay, secondDay]

        XCTAssertEqual(uiModels, viewModel.forecast)
    }

    func testEmptyWeather() {
        viewModel.setWeather(nil)
        XCTAssertTrue(viewModel.forecast.isEmpty)
    }

    private func loadMockWeather(fileName: String) -> Weather? {
        do {
            let json = try loadJSONFile(fileName)
            return try JSONDecoder().decode(Weather.self, from: json)
        } catch let error as NSError {
            XCTFail("Failed to decode json, error: \(error)")
            return nil
        }
    }

}
