//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit

struct WeatherCellUIModel: Equatable {
    var maxMinTemp: String
    var date: String
    var image: String
}

class WeatherCell: UICollectionViewCell {

    static let reuseID = String(describing: WeatherCell.self)

    private let dateLabel = InfoLabel(style: .small)
    private let maxMinLabel = InfoLabel(style: .big)

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
        addConstratints()
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
        addSubviews([imageView, dateLabel, maxMinLabel])

        backgroundColor = Constants.bgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .left
        maxMinLabel.textAlignment = .right
        maxMinLabel.numberOfLines = 2
    }

    private func addConstratints() {
        dateLabel
            .pin(edges: [.left, .bottom, .top], to: self, with: Constants.dateLabelInsets)

        imageView
            .center()
            .height(Constants.imageSide)
            .width(Constants.imageSide)
            .toRight(of: dateLabel, with: Constants.dateToImageInset)

        maxMinLabel
            .pin(edges: [.right, .bottom, .top], to: self, with: Constants.maxMinLabelLabelInsets)
            .toRight(of: imageView, with: Constants.dateToImageInset)
    }

    func setupCell(uiModel: WeatherCellUIModel) {
        dateLabel.text = uiModel.date
        maxMinLabel.text = uiModel.maxMinTemp
        imageView.downloaded(from: uiModel.image)
    }
}

extension WeatherCell {
    enum Constants {

        static let dateLabelInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0)
        static let maxMinLabelLabelInsets = UIEdgeInsets(top: 0, bottom: 0, right: 20)
        static let dateToImageInset: CGFloat = 10
        static let imageSide: CGFloat = 60

        static let cornerRadius: CGFloat = 15
        static let borderWidth: CGFloat = 3

        static let bgColor = UIColor.UI.purpleMain
        static let borderColor = UIColor.UI.purpleBorder
    }
}
