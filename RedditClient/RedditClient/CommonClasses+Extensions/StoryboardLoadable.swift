//
//  StoryboardLoadable.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import UIKit

protocol StoryboardLoadable {
    static func loadFromStoryboard(storyboardName: String?) -> Self
    static func loadFromNib(nibName: String?) -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    
    // MARK: -
    // MARK: Methods
     
    static func loadFromStoryboard(storyboardName: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboardName ?? String(describing: Self.self), bundle: Bundle(for: Self.self))
        print("Loading: "+String(describing: Self.self))
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self ?? Self()
        return controller
    }
    
    static func loadFromNib(nibName: String? = nil) -> Self {
        let controller = Self(nibName: nibName ?? String(describing: Self.self), bundle: Bundle(for: Self.self))
        print("Loading: "+String(describing: Self.self))
        return controller
    }
}
