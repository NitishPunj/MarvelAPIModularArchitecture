//
//  SceneDelegate.swift
//  MarvelAPI
//
//  Created by Sharma, Nitish X on 03/10/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appManager: AppManager!

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            appManager = AppManager(window: window)
            self.window = window
            appManager.startApp()
        }
    }
}

