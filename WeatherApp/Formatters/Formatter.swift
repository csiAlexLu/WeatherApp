//
//  Formatter.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/31/23.
//

import Foundation

class Formatter {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMM d, yyyy")
        return formatter
    }

    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("HH:mm:ss")
        return formatter
    }


}
