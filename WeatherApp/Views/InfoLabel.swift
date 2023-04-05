//
//  InfoLabel.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 4/5/23.
//

import UIKit

class InfoLabel: UILabel {

    enum Style {
        case big
        case small

        var font: UIFont {
            switch self {
            case .big: return UIFont.systemFont(ofSize: 20.0, weight: .semibold)
            case .small: return UIFont.systemFont(ofSize: 15.0, weight: .regular)
            }
        }
    }

    private var style: Style = .small

    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    func commonInit(){
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        textColor = .white
        font = style.font
    }
}
