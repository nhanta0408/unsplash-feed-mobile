//
//  AccessModel.swift
//  za-feed-excercise
//
//  Created by gcshcm on 24/03/2022.
//

import Foundation

struct TokenModel: Codable{
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    let accessToken: String
    let refreshToken: String
}
