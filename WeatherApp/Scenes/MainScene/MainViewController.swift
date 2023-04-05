//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit
import Combine

class MainViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = " Search..."
        bar.translatesAutoresizingMaskIntoConstraints = false

        return bar
    }()

    enum Constants {
        static let leadingInset: CGFloat = 20
        static let trailingInset: CGFloat = -20
        static let locationInfoHeight: CGFloat = 150
        static let forecastViewTopInset: CGFloat = 50
        static let bgColor = UIColor.UI.purpleMain
    }

    private var viewModel: MainViewModel
    private var locationVC = LocationInfoViewController()
    private var forecastVC = ForecastViewController()
    private var subscriptions: Set<AnyCancellable> = []

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        addViews()
        prepareSearhBar()
        addChildViewControllers()
        addConstratints()
        addObservers()
    }

    private func prepareUI() {
        view.backgroundColor = Constants.bgColor
    }

    private func addViews() {
        view.addSubview(searchBar)
    }

    private func prepareSearhBar() {
        searchBar.delegate = self
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
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingInset),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingInset),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.forecastViewTopInset),

            locationVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingInset),
            locationVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingInset),
            locationVC.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            locationVC.view.heightAnchor.constraint(equalToConstant: Constants.locationInfoHeight),

            forecastVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            forecastVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            forecastVC.view.topAnchor.constraint(equalTo: locationVC.view.bottomAnchor, constant: Constants.forecastViewTopInset),
            forecastVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func addObservers() {
        viewModel.$weather
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weather in
                guard let self else { return }
                self.locationVC.setWeather(weather)
                self.forecastVC.setWeather(weather)
            }
            .store(in: &subscriptions)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}
