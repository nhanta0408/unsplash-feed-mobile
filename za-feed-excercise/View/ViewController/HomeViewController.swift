//
//  ViewController.swift
//  za-feed-excercise
//
//  Created by NhanHuuTa on 23/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func loginBtnClicked(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AuthenticationViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

