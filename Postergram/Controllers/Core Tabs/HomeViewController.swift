//
//  ViewController.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 28.11.2022.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNotAuthenticated()

    }
    
    private func handleNotAuthenticated() {
        //Check Outh status
        if Auth.auth().currentUser == nil {
            //Show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
}

