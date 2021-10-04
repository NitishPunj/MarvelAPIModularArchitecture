//
//  AppManager.swift
//  MarvelAPI
//
//  Created by Sharma, Nitish X on 04/10/2021.
//

import UIKit

final class AppManager {
    private let window: UIWindow
    private let appFlowCoordinator: AppCoordinator

    init(window: UIWindow) {
        self.window = window
        self.appFlowCoordinator = AppCoordinator(window: window)
    }

    public func startApp() {
        appFlowCoordinator.start()
    }
}
