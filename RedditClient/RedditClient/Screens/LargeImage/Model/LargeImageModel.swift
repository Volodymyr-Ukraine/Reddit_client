//
//  LargeImageModel.swift
//  RedditClient
//
//  Created by Vladimir on 04.02.2021.
//

import Foundation

class LargeImageModel {
    
    public var imageName: String = ""
    public var imageData: Data? = nil
    
    public func loadImageData(_ name: String, onSuccess: @escaping (Data)->(), onError: @escaping (String)->()){
        NetworkManager.get.loadImageAndDo(name, toDo: onSuccess, onError: onError)
    }
}
