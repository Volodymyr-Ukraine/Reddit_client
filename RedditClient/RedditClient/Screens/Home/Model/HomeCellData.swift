//
//  HomeCellData.swift
//  RedditClient
//
//  Created by Vladimir on 04.02.2021.
//

import Foundation

struct HomeCellData{
    let authorName: String
    let title: String
    let entryDate: Int
    let thumbnail: String?
    let thumbnailWidth: Int
    let thumbnailHeight: Int
    var image: Data? = nil
    let numberComments: Int
}
