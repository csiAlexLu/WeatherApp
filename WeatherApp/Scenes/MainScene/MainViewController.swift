//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit
import Combine

protocol BaseViewController {
    associatedtype ViewModelType
    var viewModel: ViewModelType { get set }

    init(viewModel: ViewModelType)
}

class MainViewController: UIViewController, BaseViewController {

    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = " Search..."
        bar.translatesAutoresizingMaskIntoConstraints = false

        return bar
    }()

    var viewModel: MainViewModel
    private var locationVC = LocationInfoViewController(viewModel: LocationInfoViewModel())
    private var forecastVC = ForecastViewController(viewModel: ForecastViewModel())
    private var subscriptions: Set<AnyCancellable> = []

    required init(viewModel: MainViewModel) {
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
        searchBar
            .pin(edges: [.left, .right, .top], to: view.safeAreaLayoutGuide, with: Constants.searchBarInsets)

        locationVC.view
            .toBottom(of: searchBar)
            .pin(edges: [.left, .right], with: Constants.locationInfoInsets)
            .height(Constants.locationInfoHeight)

        forecastVC.view
            .toBottom(of: locationVC.view, with: Constants.topInset)
            .pin(edges: [.left, .right, .bottom])
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

enum Constants {
    static let searchBarInsets = UIEdgeInsets(left: 20, right: 20)
    static let locationInfoInsets = UIEdgeInsets(top: 10, left: 20, right: 20)
    static let locationInfoHeight: CGFloat = 150
    static let topInset: CGFloat = 20
    static let bgColor = UIColor.white
}
