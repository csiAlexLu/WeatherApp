//
//  LocationInfoViewModelTests.swift
//  WeatherAppTests
//
//  Created by Alexander Luchenok on 4/4/23.
//

import XCTest
@testable import WeatherApp

final class LocationInfoViewModelTests: XCTestCase, JsonLoadable {

    var viewModel: LocationInfoViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()

        viewModel = LocationInfoViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testUiModel() {
        let bostonWeather = loadMockWeather(fileName: "bostonWeatherData")
        let bostonUiModel = LocationInfoUIModel(city: "Boston", country: "United States of America", time: "05:48:06", date: "Apr 4, 2023")

        let warsawWeather = loadMockWeather(fileName: "warsawWeatherData")
        let warsawUiModel = LocationInfoUIModel(city: "Warsaw", country: "Poland", time: "13:41:10", date: "Apr 4, 2023")

        viewModel.setWeather(bostonWeather)
        XCTAssertEqual(bostonUiModel, viewModel.uiModel)
        viewModel.setWeather(warsawWeather)
        XCTAssertEqual(warsawUiModel, viewModel.uiModel)
    }

    func testEmptyWeather() {
        viewModel.setWeather(nil)
        XCTAssertNil(viewModel.uiModel)
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
