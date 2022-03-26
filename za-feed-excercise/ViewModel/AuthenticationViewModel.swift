//
//  AuthenticationViewModel.swift
//  za-feed-excercise
//
//  Created by NhanHuuTa on 24/03/2022.
//

import Foundation

class AuthenticationViewModel: AuthenticationViewModelProtocol{
    var authRepository: AuthRepository?

    init(authRepository: AuthRepository = AuthRepository()){
        self.authRepository = authRepository
    }
    
  
    
    
    func generateTheAuthenticationUrl() -> String{
        return "https://unsplash.com/oauth/authorize?client_id=\(Constant.clientId)&redirect_uri=\(Constant.redirectUri)&response_type=code&scope=public+read_user+write_user+read_photos+write_photos+write_likes+write_followers+read_collections+write_collections"
    }
    // Based on the url, get the authentication code
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
