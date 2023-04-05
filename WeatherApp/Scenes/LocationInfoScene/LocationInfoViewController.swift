//
//  LocationInfoViewController.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit
import Combine

class LocationInfoViewController: UIViewController, BaseViewController {

    enum Constants {
        static let leadingInset: CGFloat = 20
        static let trailingInset: CGFloat = -20
        static let verticalInset: CGFloat = 15
        static let mainInfoHeight: CGFloat = 30
        static let additionalInfoHeight: CGFloat = 20

        static let cornerRadius: CGFloat = 15
        static let borderWidth: CGFloat = 3


        static let mainInfoFont = UIFont.systemFont(ofSize: 30.0, weight: .semibold)
        static let additionalInfoFont = UIFont.systemFont(ofSize: 15.0, weight: .regular)

        static let bgColor = UIColor.UI.purpleMain
        static let borderColor = UIColor.UI.purpleBorder
    }

    private let citylabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = Constants.mainInfoFont
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private let countylabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = Constants.additionalInfoFont
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private let timelabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = Constants.mainInfoFont
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private let datelabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = Constants.additionalInfoFont
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

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
        addViews()
        addConstratints()
        addObservers()
    }

    private func prepareUI() {
        view.backgroundColor = Constants.bgColor
    }

    private func addViews() {
        view.addSubview(citylabel)
        view.addSubview(countylabel)
        view.addSubview(timelabel)
        view.addSubview(datelabel)
    }

    private func addConstratints() {
        NSLayoutConstraint.activate([
            citylabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingInset),
            citylabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingInset),
            citylabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.verticalInset),
            citylabel.heightAnchor.constraint(equalToConstant: Constants.mainInfoHeight),

            countylabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingInset),
            countylabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingInset),
            countylabel.topAnchor.constraint(equalTo: citylabel.bottomAnchor),
            countylabel.heightAnchor.constraint(equalToConstant: Constants.additionalInfoHeight),

            timelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingInset),
            timelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingInset),
            timelabel.topAnchor.constraint(equalTo: countylabel.bottomAnchor, constant: Constants.verticalInset),
            timelabel.heightAnchor.constraint(equalToConstant: Constants.mainInfoHeight),

            datelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingInset),
            datelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingInset),
            datelabel.topAnchor.constraint(equalTo: timelabel.bottomAnchor),
            datelabel.heightAnchor.constraint(equalToConstant: Constants.additionalInfoHeight),
        ])
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
