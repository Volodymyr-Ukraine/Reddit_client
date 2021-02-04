//
//  TopFeedStructure.swift
//  RedditClient
//
//  Created by Vladimir on 04.02.2021.
//

import Foundation

struct TopFeedStructure: Codable {
    let data: SearchData
}

struct SearchData: Codable{
    let children: [Child]
    let after: String?
    let before: String?
}

struct Child: Codable{
    let data: ChildData
}

struct ChildData: Codable{
    let author: String
    let title: String
    let thumbnailWidth: Int?
    let thumbnailHeight: Int?
    let thumbnail: String
    let created: Int
    let numComments: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case thumbnailWidth = "thumbnail_width"
        case thumbnailHeight = "thumbnail_height"
        case thumbnail
        case created
        case numComments = "num_comments"
        case url
    }
}

struct Media: Codable {
    let redditVideo: RedditVideo

    enum CodingKeys: String, CodingKey {
        case redditVideo = "reddit_video"
    }
}

struct RedditVideo: Codable {
    let fallbackURL: String
    let height, width: Int
    let scrubberMediaURL: String
    let dashURL: String
    let duration: Int
    let hlsURL: String
    let isGIF: Bool
    let transcodingStatus: String

    enum CodingKeys: String, CodingKey {
            case fallbackURL = "fallback_url"
            case height, width
            case scrubberMediaURL = "scrubber_media_url"
            case dashURL = "dash_url"
            case duration
            case hlsURL = "hls_url"
            case isGIF = "is_gif"
            case transcodingStatus = "transcoding_status"
        }
}
