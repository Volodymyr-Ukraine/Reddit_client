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
    public var nextUrlName: String? = nil
    
    // MARK: -
    // MARK: Private Properties
    
    private var isLoading: Bool = false
     
    // MARK: -
    // MARK: Public Methods
    
    public func refreshCurrentData(onSuccess: @escaping ()->(), onError: @escaping (String)->()){
        guard !isLoading else {
            return
        }
        let onOk: ([HomeCellData], String?)->() = { [weak self] data, nextUrlString in
            self?.data += data
            self?.nextUrlName = nextUrlString
            DispatchQueue.main.async { [weak self] in
                onSuccess()
                self?.isLoading = false
            }
        }
        let errorHappens: (String)->() = { [weak self] message in
            self?.isLoading = false
            DispatchQueue.main.async {
                onError(message)
            }
        }
        self.isLoading = true
        NetworkManager.get.getTopFeed(next: nextUrlName, onSuccess: onOk, onError: errorHappens)
    }
}

