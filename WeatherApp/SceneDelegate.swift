//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 3/30/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var router: Router!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)

        router = Router(window: window)
        router.navigate(to: .root)
    }
}

