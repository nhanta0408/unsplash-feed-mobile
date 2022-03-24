//
//  PostModel.swift
//  za-feed-excercise
//
//  Created by gcshcm on 24/03/2022.
//

import Foundation


struct PostModel: Codable{
    enum CodingKeys: String, CodingKey {
        case urls
        case likes
       case likedByUser = "liked_by_user"
        case user
    }
    
    let urls: Url
    let likes: Int
    let likedByUser: Bool
    let user: User
}

struct User: Codable {
    let username: String
}

struct Url: Codable {
    enum CodingKeys: String, CodingKey {
        case fullSize = "full"
    }
    let fullSize: String
}
