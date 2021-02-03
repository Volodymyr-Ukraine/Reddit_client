//
//  HomeViewController.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import UIKit

enum HomeEvent{
    case showLargeImage
}

class HomeViewController: UIViewController, StoryboardLoadable {

    // MARK: -
    // MARK: Properties
    
    public var model: HomeModel = HomeModel()
    public var eventHandler: ((HomeEvent)->())?
    private var mainView: HomeView? {
        return self.view as? HomeView
    }
        
    // MARK: -
    // MARK: Init and Deinit
    
    public static func startVC() -> Self {
        let controller = self.loadFromNib()
        return controller
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
    
    // MARK: -
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
