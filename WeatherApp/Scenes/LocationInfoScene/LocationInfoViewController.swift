//
//  LocationInfoViewController.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit

class LocationInfoViewController: UIViewController {

    // MARK: - Constants
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

        static let purpleMain = UIColor(named: "purpleMain")!
        static let purpleBorder = UIColor(named: "purpleBorder")!
    }

    // MARK: - UI
    private let citylabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Minsk"
        label.font = Constants.mainInfoFont
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private let countylabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Belarus"
        label.font = Constants.additionalInfoFont
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private let timelabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "14:09"
        label.font = Constants.mainInfoFont
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private let datelabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "30.03.2023"
        label.font = Constants.additionalInfoFont
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    // MARK: - Life cycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = Constants.purpleBorder.cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.purpleMain

        addViews()
        addConstratints()
    }

    // MARK: - Private functions
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
}
