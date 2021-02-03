//
//  MainCoordinator.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import UIKit

enum AvailableMenuScreens: Equatable, Hashable {
    case home
    case largeImage
}

final class MainCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Properties
    
    let navigationController: UINavigationController
    private var cache: [AvailableMenuScreens: AnyObject?] = [:]
    internal var navigationScreens: [AvailableMenuScreens] = []
    internal var choosenScreen: AvailableMenuScreens? {
        willSet{
            switch newValue {
            case nil:
                self.start()
            case .home:
                self.makeHome()
            case .largeImage:
                self.makeLargeImage()
            }
        }
    }
    
    // MARK: -
    // MARK: Init and Deinit
        
    init(_ navController: UINavigationController) {
        self.navigationController = navController
    }
        
    func start() {
        self.choosenScreen = .home
    }
        
    func continueAgain() {
        guard let contr = self.navigationController.viewControllers.last else {
            self.start()
            return
        }
        self.navigationController.pushViewController(contr, animated: true)
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
    
    // MARK: -
    // MARK: Internal Methods
    
    func makeLargeImage(){
//        let contr =
//        contr.eventHandler =
//        self.navigationController.pushViewController(contr, animated: true)
        self.cleanControllersStack()
    }
    
    func makeHome(){
        let contr = HomeViewController.startVC()
        contr.eventHandler = {[weak self] event in
            switch event {
            case .showLargeImage:
                self?.choosenScreen = .largeImage
                }
            }
        self.navigationController.pushViewController(contr, animated: true)
        self.cleanControllersStack()
    }
}

extension MainCoordinator {
    
    // MARK: -
    // MARK: Public Methods
    
    public func jumpBack(){
        self.navigationScreens = self.navigationScreens.dropLast()
        self.choosenScreen = self.navigationScreens.last
    }
    
    // MARK: -
    // MARK: Internal Methods
    
    internal func showError(_ message: String) {
        showError(message, onCompletion: {self.choosenScreen = nil})
    }
    
    internal func showError(_ message: String, onCompletion: @escaping (()->())) {
        let alert = UIAlertController(title: "Error".localize(), message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK".localize(), style: .cancel, handler: { action in
            onCompletion()
        }))
        alert.addAction(.init(title: "Cancel".localize(), style: .default, handler: {action in
            onCompletion()
        }))
        self.navigationController.pushViewController(alert, animated: true)
    }
}

