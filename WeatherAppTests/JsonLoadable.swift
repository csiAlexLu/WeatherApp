//
//  JsonLoadable.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 4/4/23.
//

import Foundation

enum JsonLoadableError: Error {
    case failedToLoadJSONFile
}

protocol JsonLoadable: AnyObject {
    func loadJSONFile(_ fileName: String) throws -> Data
}

extension JsonLoadable {
    func loadJSONFile(_ fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let filePath = bundle.path(forResource: fileName, ofType: "json") else {
            throw JsonLoadableError.failedToLoadJSONFile
        }
        let url = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: url)
        return data
    }
}
