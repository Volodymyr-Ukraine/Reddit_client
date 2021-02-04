//
//  HomeModel.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import Foundation

class HomeModel {
    
    // MARK: -
    // MARK: Public Properties
    
    public var data: [HomeCellData] = []
    
    // MARK: -
    // MARK: Private Properties
    
    private var nextUrlName: String? = nil
     
    // MARK: -
    // MARK: Public Methods
    
    public func refreshCurrentData(onSuccess: @escaping ()->(), onError: @escaping (String)->()){
        let onOk: ([HomeCellData], String?)->() = { [weak self] data, nextUrlString in
            self?.data += data
            self?.nextUrlName = nextUrlString
            DispatchQueue.main.async {
                onSuccess()
            }
        }
        
        NetworkManager.get.getTopFeed(next: nextUrlName, onSuccess: onOk, onError: onError)
    }
}

