//
//  Repository.swift
//  za-feed-excercise
//
//  Created by NhanHuuTa on 24/03/2022.
//

import Foundation

class AuthRepository{
    
    func generateUrlForGetAccessToken(codeOrToken: String, isRefreshToken: Bool) -> String {
        if(isRefreshToken){
            return Constant.baseUrl + "/oauth/token" + "?client_id=" + Constant.clientId + "&client_secret=" + Constant.clientSecret + "&redirect_uri=" + Constant.redirectUri + "&refresh_token=" + codeOrToken + "&grant_type=" + GrantType.refreshToken.rawValue
        }
        else{
            return Constant.baseUrl + "/oauth/token" + "?client_id=" + Constant.clientId + "&client_secret=" + Constant.clientSecret + "&redirect_uri=" + Constant.redirectUri + "&code=" + codeOrToken + "&grant_type=" + GrantType.authorizationCode.rawValue
        }
    }
    func getAccessToken(codeOrToken: String, isRefreshToken: Bool, completion: @escaping VoidClosure){
        let urlString = generateUrlForGetAccessToken(codeOrToken: codeOrToken, isRefreshToken: isRefreshToken)
        let url = URL(string: urlString)!
        let task = URLSession(configuration: .default).dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
                guard let data = data else { return }
                if let decodedResponse = try? JSONDecoder().decode(TokenModel.self, from: data) {
                    
                    accessToken = decodedResponse.accessToken
                    refreshToken = decodedResponse.refreshToken
                    print("Here is accessToken: \(accessToken)")
                    print("Here is refreshToken: \(refreshToken)")
                    completion()
                }
            }
            task.resume()
    }
}
