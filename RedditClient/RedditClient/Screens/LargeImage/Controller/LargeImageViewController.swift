//
//  LargeImageViewController.swift
//  RedditClient
//
//  Created by Vladimir on 04.02.2021.
//

import UIKit

enum LargeImageEvent{
    case cancelPressed
    case savePressed
}

class LargeImageViewController: UIViewController, StoryboardLoadable {

    
    // MARK: -
    // MARK: Properties
    
    public var model: LargeImageModel = LargeImageModel()
    public var eventHandler: ((LargeImageEvent)->())?
    private var mainView: LargeImageView? {
        return self.view as? LargeImageView
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

    public func loadImage(url: String) {
        self.model.loadImageData(
            url,
            onSuccess: { [weak self] data in
                self?.mainView?.setImage(data: data)
            },
            onError: { [weak self] message in
                self?.showStandardError(message)
            })
    }
    
    @IBAction
    public func cancelPressed(){
        self.eventHandler?(.cancelPressed)
    }

    @IBAction
    public func savePressed(){
        self.eventHandler?(.savePressed)
    }
}
