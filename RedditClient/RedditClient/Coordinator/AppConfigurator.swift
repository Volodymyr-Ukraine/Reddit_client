//
//  AppConfigurator.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import UIKit

final class AppConfigurator {
    
    // MARK: -
    // MARK: Properties
    
    private var coordinator: Coordinator? 

    // MARK: -
    // MARK: Init and Deinit
    
    init(window: UIWindow) {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        navigationController.navigationBar.isHidden = true
        self.configure(window: window, navigationController: navigationController)
    }

    // MARK: -
    // MARK: Methods
    
    private func configure(window: UIWindow, navigationController: UINavigationController) {
        
        let menu = MainCoordinator(navigationController)
        self.coordinator = menu
        
        self.coordinator?.start()
        window.makeKeyAndVisible()
    }
}
