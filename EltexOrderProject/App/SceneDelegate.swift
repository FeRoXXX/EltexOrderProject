//
//  SceneDelegate.swift
//  EltexOrderProject
//
//  Created by Александр Федоткин on 16.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: MainNavigationModuleAssembly.build())
        self.window = window
    }
}

