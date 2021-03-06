//
//  Constant.swift
//  za-feed-excercise
//
//  Created by NhanHuuTa on 24/03/2022.
//

import Foundation

struct Constant{
    static let baseUrl = "https://unsplash.com"
    static let basetApiUrl = "https://api.unsplash.com"
    static let clientId = "Vxq9CSSRhOpqEsYM0UnMig7H8_TBt6dqW_3Q2o4d9UQ"
    static let clientSecret = "1qKCNzgwkWitM5ZQykn04Zojx7yrZ6yGGcmMUq_j2bA"
    static let redirectUri = "urn:ietf:wg:oauth:2.0:oob"
    
    static let maximumPosts = 30
    static let numberOfPostsPerPage = 10
}


enum GrantType: String {
    case authorizationCode = "authorization_code"
    case refreshToken = "refresh_token"
}
