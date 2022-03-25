//
//  AuthenticationViewController.swift
//  za-feed-excercise
//
//  Created by gcshcm on 24/03/2022.
//

import UIKit
import WebKit

class AuthenticationViewController: UIViewController{

    @IBOutlet weak var webView: WKWebView!
    let authenticationViewModel: AuthenticationViewModelProtocol = AuthenticationViewModel()
    var authenticationCode: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
              
        let url = URL(string: authenticationViewModel.generateTheAuthenticationUrl())!
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.navigationDelegate = self;
    }
}

extension AuthenticationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        let currentURLString = webView.url?.absoluteString;
        authenticationCode = authenticationViewModel.checkHasAuthorizationCode(currentUrlString: currentURLString ?? "");
        //Received authenticationCode
        if(authenticationCode != "") {
            authenticationViewModel.getAccessToken(codeOrToken: authenticationCode, isRefreshToken: false)
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GalleryViewController")
            vc.title = "Gallerry View Controller"
            vc.navigationItem.hidesBackButton = true;
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
