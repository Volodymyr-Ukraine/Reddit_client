//
//  LargeImageView.swift
//  RedditClient
//
//  Created by Vladimir on 04.02.2021.
//

import UIKit

class LargeImageView: UIView {

    // MARK: -
    // MARK: Internal Objects
    
    struct Sizes{
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: -
    // MARK: Properties
    
    @IBOutlet private var imageView: UIImageView?
    @IBOutlet private var cancelButton: UIButton?
    @IBOutlet private var saveButton: UIButton?
    
    // MARK: -
    // MARK: Public Methods
    
    public func setImage(data: Data){
        prepareUI()
        self.imageView?.image = UIImage(data: data)
    }
    
    public func getImage() -> UIImage? {
        return self.imageView?.image
    }
    
    // MARK: -
    // MARK: Private Methods
    
    private func prepareUI(){
        self.cancelButton?.layer.cornerRadius = Sizes.cornerRadius
        self.saveButton?.layer.cornerRadius = Sizes.cornerRadius
    }

}
