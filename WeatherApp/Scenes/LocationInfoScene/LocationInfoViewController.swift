//
//  LocationInfoViewController.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit
import Combine

class LocationInfoViewController: UIViewController, BaseViewController {

    private let citylabel = InfoLabel(style: .big)
    private let countylabel = InfoLabel(style: .small)
    private let timelabel = InfoLabel(style: .big)
    private let datelabel = InfoLabel(style: .small)

    var viewModel: LocationInfoViewModel
    private var subscriptions: Set<AnyCancellable> = []

    required init(viewModel: LocationInfoViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = Constants.borderColor.cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        addConstratints()
        addObservers()
    }

    private func prepareUI() {
        let labels = [citylabel, countylabel, timelabel, datelabel]
        view.addSubviews(labels)
        view.backgroundColor = Constants.bgColor
        labels.forEach { $0.textAlignment = .center }
    }

    private func addConstratints() {
        citylabel
            .pin(edges: [.left, .right, .top], to: self.view, with: Constants.cityLabelInsets)
            .height(Constants.mainInfoHeight)

        countylabel
            .toBottom(of: citylabel)
            .pin(edges: [.left, .right], to: self.view, with: Constants.countryLabelInsets)
            .height(Constants.additionalInfoHeight)

        timelabel
            .toBottom(of: countylabel, with: Constants.verticalInset)
            .pin(edges: [.left, .right], to: self.view, with: Constants.countryLabelInsets)
            .height(Constants.mainInfoHeight)

        datelabel
            .toBottom(of: timelabel)
            .pin(edges: [.left, .right], to: self.view, with: Constants.countryLabelInsets)
            .height(Constants.additionalInfoHeight)
    }

    private func addObservers() {
        viewModel.$uiModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] uiModel in
                guard let self else { return }
                if let uiModel {
                    self.citylabel.text = uiModel.city
                    self.countylabel.text = uiModel.country
                    self.timelabel.text = uiModel.time
                    self.datelabel.text = uiModel.date
                } else {
                    self.clearView()
                }

            }
            .store(in: &subscriptions)
    }

    private func clearView() {
        self.citylabel.text = ""
        self.countylabel.text = ""
        self.timelabel.text = ""
        self.datelabel.text = ""
    }

    func setWeather(_ weather: Weather?) {
        viewModel.setWeather(weather)
    }
}

extension LocationInfoViewController {
    enum Constants {
        static let cityLabelInsets = UIEdgeInsets(top: 15, left: 20, right: 20)
        static let countryLabelInsets = UIEdgeInsets(left: 20, right: 20)
        static let verticalInset: CGFloat = 15
        static let mainInfoHeight: CGFloat = 30
        static let additionalInfoHeight: CGFloat = 20
        static let cornerRadius: CGFloat = 15
        static let borderWidth: CGFloat = 3
        static let bgColor = UIColor.UI.purpleMain
        static let borderColor = UIColor.UI.purpleBorder
    }
}
