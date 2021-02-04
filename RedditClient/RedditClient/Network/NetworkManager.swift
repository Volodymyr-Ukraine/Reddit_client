//
//  NetworkManager.swift
//  RedditClient
//
//  Created by Vladimir on 04.02.2021.
//

import Foundation

class NetworkManager {
    
    // MARK: -
    // MARK: Singletone
    
    public static let get = NetworkManager()
    private init(){
    }
    
    // MARK: -
    // MARK: Private Constants
    
    private let mainUrl = "https://www.reddit.com/"
    private let topJson = "top.json"
    
    // MARK: -
    // MARK: Public Methods
    
    public func getTopFeed(next: String?, onSuccess: @escaping ([HomeCellData], String?)->(), onError: @escaping (String)->()) {
        guard var urlComponent = URLComponents(string: mainUrl + topJson)
            else {return}
        if next != nil {
            urlComponent.queryItems = [URLQueryItem(name: "after", value: next)]
        }
        guard let url = urlComponent.url else {
            onError("wrong url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { [weak self] optionalData, response, sessionError in
            guard let data = optionalData else {
                onError(sessionError?.localizedDescription ?? "Wrong catched data. Check Internet connection and try again")
                return
            }
            do {
                let decoder = JSONDecoder()
                let pageInfo = try decoder.decode(TopFeedStructure.self, from: data)
                print("\(#function) done")
                print(pageInfo)
                let childrens = pageInfo.data.children
                onSuccess(childrens.compactMap{
                    return HomeCellData(
                        authorName: $0.data.author,
                        title: $0.data.title,
                        entryDate: $0.data.created,
                        thumbnail: $0.data.thumbnail,
                        thumbnailWidth: $0.data.thumbnailWidth ?? 1,
                        thumbnailHeight: $0.data.thumbnailHeight ?? 1,
                        numberComments: $0.data.numComments,
                        bigImageUrl: $0.data.url)
                }, pageInfo.data.after) 
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    public func loadImageAndDo(_ urlString: String, toDo: @escaping (Data)->(), onError: @escaping (String)->()){
        let cache =  URLCache.shared
        guard let imageURL = URL(string: urlString) else {return}
        let request = URLRequest(url: imageURL)
        if let data = cache.cachedResponse(for: request)?.data {
            toDo(data)
        } else {
            URLSession.shared.dataTask(with: request){ optionalData, response, sessionError in
                guard let data = optionalData,
                      let response = response,
                      ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300
                else {
//                    DispatchQueue.main.async {
//                        onError("wrong response: \(sessionError?.localizedDescription ?? "empty")")
//                    }
                    return
                }
                let cachedData = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                DispatchQueue.main.async {
                    toDo(data)
                }
            }
            .resume()
        }
    }
    
    // MARK: -
    // MARK: Private Methods
    
    private func decodeTopFeed(data: Data){
        
    }
}
