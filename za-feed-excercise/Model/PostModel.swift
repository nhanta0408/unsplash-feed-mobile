//
//  PostModel.swift
//  za-feed-excercise
//
//  Created by NhanHuuTa on 24/03/2022.
//

import Foundation


struct PostModel: Codable{
    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case likes
        case likedByUser = "liked_by_user"
        case user
    }
    let id: String
    let urls: UrlModel
    let likes: Int
    let likedByUser: Bool
    let user: UserModel
}

struct UserModel: Codable {
    let username: String
}

struct UrlModel: Codable {
    enum CodingKeys: String, CodingKey {
        case regularSize = "regular"
    }
    let regularSize: String
}
