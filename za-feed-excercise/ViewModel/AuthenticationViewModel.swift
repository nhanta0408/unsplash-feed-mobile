//
//  AuthenticationViewModel.swift
//  za-feed-excercise
//
//  Created by gcshcm on 24/03/2022.
//

import Foundation

class AuthenticationViewModel: AuthenticationViewModelProtocol{
    var authRepository: AuthRepository?

    init(authRepository: AuthRepository = AuthRepository()){
        self.authRepository = authRepository
    }
    
    let clientId = "Vxq9CSSRhOpqEsYM0UnMig7H8_TBt6dqW_3Q2o4d9UQ"
    let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    
    
    func generateTheAuthenticationUrl() -> String{
        return "https://unsplash.com/oauth/authorize?client_id=\(clientId)&redirect_uri=\(redirectURI)&response_type=code&scope=public+read_user+write_user+read_photos+write_photos+write_likes+write_followers+read_collections+write_collections"
    }
    func checkHasAuthorizationCode(currentUrlString: String) -> String{
        if (currentUrlString.contains("https://unsplash.com/oauth/authorize/native?code=")){
            return currentUrlString.components(separatedBy: "=")[1];
        }
        else{
            return ""
        }
    }
    func getAccessToken(codeOrToken: String, isRefreshToken: Bool, completion: @escaping VoidClosure){
        authRepository?.getAccessToken(codeOrToken: codeOrToken, isRefreshToken: isRefreshToken) {
            completion()
        }
    }
}
