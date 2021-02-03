//
//  String+Localization.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import Foundation

private var bundle = Bundle.main

public func setLocalization(_ localization: String) {
    guard let path = Bundle.main.path(forResource: localization, ofType: "lproj") else {return}
    bundle = Bundle.init(path: path) ?? Bundle.main
}

public func localized(_ string: String, comment: String = "") -> String {
    return NSLocalizedString(string, tableName: "Description", bundle:  bundle, comment: comment)
}

extension String {
    public func localize() -> String {
        return localized(self)
    }
}
