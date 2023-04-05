//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit

struct WeatherCellUIModel {
    var maxMinTemp: String
    var date: String
    var image: UIImage
}

class WeatherCell: UICollectionViewCell {

    static let reuseID = String(describing: WeatherCell.self)

    enum Constants {
        static let leadingInset: CGFloat = 20
        static let trailingInset: CGFloat = -20
        static let tempToImageInset: CGFloat = 10
        static let dateToImageInset: CGFloat = -10
        static let imageSide: CGFloat = 60

        static let cornerRadius: CGFloat = 15
        static let borderWidth: CGFloat = 3

        static let tempFont = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        static let dateFont = UIFont.systemFont(ofSize: 15.0, weight: .regular)

        static let bgColor = UIColor.UI.purpleMain
        static let borderColor = UIColor.UI.purpleBorder
    }

    private let dateLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = Constants.dateFont
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private let maxMinLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = Constants.tempFont
        label.textAlignment = .right
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
        addConstratints()
        prepareUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.borderColor.cgColor
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = ""
        maxMinLabel.text = ""
        imageView.image = nil
    }

    private func prepareUI() {
        backgroundColor = Constants.bgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false 
    }

    private func addViews() {
        addSubview(dateLabel)
        addSubview(maxMinLabel)
        addSubview(imageView)
    }

    private func addConstratints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingInset),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: Constants.dateToImageInset),

            maxMinLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.trailingInset),
            maxMinLabel.topAnchor.constraint(equalTo: self.topAnchor),
            maxMinLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            maxMinLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.tempToImageInset),

            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageSide),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSide)
        ])
    }

    func setupCell(uiModel: WeatherCellUIModel) {
        dateLabel.text = uiModel.date
        maxMinLabel.text = uiModel.maxMinTemp
        imageView.image = uiModel.image
    }
}
