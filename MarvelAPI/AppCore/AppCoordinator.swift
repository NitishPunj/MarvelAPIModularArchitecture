//
//  AppCoordinator.swift
//  MarvelAPI
//
//  Created by Sharma, Nitish X on 04/10/2021.
//

import UIKit
import MarvelAPIService

final class AppCoordinator {
    
    private let window: UIWindow
    private let navigationController = UINavigationController()
    
    
    init(window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let viewModel =  CharactersViewModel(service: MarvelService())
        let vc = CharactersViewController(viewModel: viewModel, coordinator: self)
        navigationController.setViewControllers([vc], animated: true)
    }
}

// MARK:- AppCoordinator: CharactersViewControllerCoordinator
extension AppCoordinator: CharactersViewControllerCoordinator {
    func showDetail(character: MarvelCharacter) {
        let detailvc = CharacterDetailViewController(viewModel: character)
        navigationController.pushViewController(detailvc, animated: true)
    }
}
