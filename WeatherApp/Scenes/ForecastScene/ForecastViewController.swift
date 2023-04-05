//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit
import Combine

class ForecastViewController: UIViewController {

    enum Constants {
        static let leadingInset: CGFloat = 20
        static let cellHeigth: CGFloat = 90
        static let contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    private let forecastCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.reuseID)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentInset = Constants.contentInset
        return collection
    }()

    var viewModel = ForecastViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        prepareCollectionView()
        addConstratints()
        addObservers()
    }

    private func prepareUI() {
        view.backgroundColor = .clear
    }

    private func prepareCollectionView() {
        view.addSubview(forecastCollectionView)

        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
    }
    
    private func addConstratints() {
        NSLayoutConstraint.activate([
            forecastCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forecastCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            forecastCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func addObservers() {
        viewModel.$forecast
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.forecastCollectionView.reloadData()
            }
            .store(in: &subscriptions)
    }

    func setWeather(_ weather: Weather?) {
        viewModel.setWeather(weather)
    }
}

extension ForecastViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.forecast.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.reuseID, for: indexPath) as? WeatherCell else {
            return UICollectionViewCell()
        }

        cell.setupCell(uiModel: viewModel.forecast[indexPath.item])

        return cell
    }
}

extension ForecastViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let insets = collectionView.contentInset
        let availableWidth = collectionView.bounds.width - insets.left - insets.right

        return CGSize(width: availableWidth, height: Constants.cellHeigth)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        forecastCollectionView.collectionViewLayout.invalidateLayout()
    }
}
