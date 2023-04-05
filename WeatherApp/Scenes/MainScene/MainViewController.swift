//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit

class MainViewController: UIViewController {

    enum Constants {
        static let leadingInset: CGFloat = 20
        static let trailingInset: CGFloat = -20
        static let locationInfoHeight: CGFloat = 150
        static let forecastViewTopInset: CGFloat = 50
        static let backgroundColor = UIColor(named: "purpleMain")!.withAlphaComponent(0.8)
    }

    private var locationVC = LocationInfoViewController()
    private var forecastVC = ForecastViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        addChildViewControllers()
        addConstratints()
    }

    private func prepareUI() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func addChildViewControllers() {
        view.addSubview(locationVC.view)
        addChild(locationVC)
        locationVC.didMove(toParent: parent)
        locationVC.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(forecastVC.view)
        addChild(forecastVC)
        forecastVC.didMove(toParent: parent)
        forecastVC.view.translatesAutoresizingMaskIntoConstraints = false

    }

    private func addConstratints() {
        NSLayoutConstraint.activate([
            locationVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingInset),
            locationVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingInset),
            locationVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationVC.view.heightAnchor.constraint(equalToConstant: Constants.locationInfoHeight),

            forecastVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            forecastVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            forecastVC.view.topAnchor.constraint(equalTo: locationVC.view.bottomAnchor, constant: Constants.forecastViewTopInset),
            forecastVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
