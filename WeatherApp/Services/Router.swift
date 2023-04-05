//
//  Router.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 4/4/23.
//

import UIKit

enum Route {
    case root
}

protocol RouterProtocol {
    func navigate(to route: Route)
}

class Router: RouterProtocol {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func navigate(to route: Route) {
        switch route {
        case .root:
            let main = MainViewController(viewModel: MainViewModel(weatherService: WeatherService()))
            window.rootViewController = main
            window.makeKeyAndVisible()
        }
    }
}


