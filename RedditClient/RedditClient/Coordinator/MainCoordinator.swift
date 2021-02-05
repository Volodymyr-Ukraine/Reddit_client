//
//  MainCoordinator.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import UIKit

enum AvailableMenuScreens: Equatable, Hashable {
    case home
    case largeImage(String)
}

final class MainCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Properties
    
    let navigationController: UINavigationController
    private var cache: [AvailableMenuScreens: AnyObject?] = [:]
    internal var choosenScreen: AvailableMenuScreens? {
        willSet{
            switch newValue {
            case nil:
                self.start()
            case .home:
                self.makeHome()
            case .largeImage(let url):
                self.makeLargeImage(url)
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
//        NetworkManager.get.getTopFeed(page: "")
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
    
    func makeLargeImage(_ urlString: String){
        let contr = LargeImageViewController.startVC()
        contr.loadImage(url: urlString)
        contr.eventHandler = { [weak self, weak contr] event in
            switch event {
            case .done:
                self?.choosenScreen = .home
            }
            
        }
        self.navigationController.pushViewController(contr, animated: false)
    }
    
    func makeHome(){
        let contr = HomeViewController.startVC()
        contr.model = (self.cache[.home] as? HomeModel) ?? HomeModel()
        contr.eventHandler = {[weak self, weak contr] event in
            self?.cache[.home] = contr?.model
            switch event {
            case .showLargeImage(let url):
                self?.choosenScreen = .largeImage(url)
                }
            }
        self.navigationController.pushViewController(contr, animated: true)
        self.cleanControllersStack()
    }
}
