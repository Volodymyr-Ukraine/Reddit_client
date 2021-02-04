//
//  UIViewController+ShowError.swift
//  RedditClient
//
//  Created by Vladimir on 04.02.2021.
//

import UIKit

extension UIViewController {
    public func showStandardError(_ message: String, onOk: (()->())? = nil) {
        let alert = UIAlertController(title: "Error".localize(), message: message, preferredStyle: .alert)
        let onAlert: (UIAlertAction) -> Void = { _ in
            onOk?()
        }
        alert.addAction(.init(title: "OK".localize(), style: .cancel, handler: onAlert))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func showStandardMessage(with header: String, message: String, onOk: (()->())? = nil) {
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        let onAlert: (UIAlertAction)->() = { _ in
            onOk?()
        }
        alert.addAction(.init(title: "OK".localize(), style: .cancel, handler: onAlert))
        self.present(alert, animated: true, completion: nil)
    }
}
