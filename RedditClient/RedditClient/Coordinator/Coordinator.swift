//
//  Coordinator.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    func start()
    func continueAgain()
    func cleanControllersStack()
}

extension Coordinator {
    func cleanControllersStack() {
        let controllersCount = self.navigationController.viewControllers.count
        self.navigationController.viewControllers.removeFirst(controllersCount - 1)
    }
}
