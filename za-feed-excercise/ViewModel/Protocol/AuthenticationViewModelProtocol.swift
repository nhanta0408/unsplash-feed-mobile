//
//  AuthenticationViewModelProtocol.swift
//  za-feed-excercise
//
//  Created by NhanHuuTa on 25/03/2022.
//

import Foundation

protocol AuthenticationViewModelProtocol {
    var authRepository: AuthRepository? {get}
    func generateTheAuthenticationUrl() -> String
    func checkHasAuthorizationCode(currentUrlString: String) -> String
    func getAccessToken(codeOrToken: String, isRefreshToken: Bool, completion: @escaping VoidClosure)
}
