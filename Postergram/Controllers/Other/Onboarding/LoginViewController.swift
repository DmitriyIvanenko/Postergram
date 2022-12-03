//
//  LoginViewController.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 28.11.2022.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        static let buttonHeight: CGFloat = 52.0
        static let termsUrl: String = "https://google.com"
        static let policyUrl: String = "https://yahoo.com"
    }
    
    private let headerView: UIView = {
        let header =  UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    private let userNameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10.0, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10.0, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Polic", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    
    //MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        userNameEmailField.delegate = self
        passwordField.delegate = self
        
        addSubViews()
        
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - Asign frames
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
 
        headerView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.widthExt,
            height: view.heightExt / 3
        )
        
        userNameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottomExt + 30,
            width: view.widthExt - 50,
            height: Constants.buttonHeight
        )
        
        passwordField.frame = CGRect(
            x: 25,
            y: userNameEmailField.bottomExt + 20,
            width: view.widthExt - 50,
            height: Constants.buttonHeight
        )
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottomExt + 30,
            width: view.widthExt - 50,
            height: Constants.buttonHeight
        )
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottomExt + 10,
            width: view.widthExt - 50,
            height: Constants.buttonHeight
        )
        
        stackView.addArrangedSubview(termsButton)
        stackView.addArrangedSubview(privacyButton)
        stackView.translatesAutoresizingMaskIntoConstraints = true
        stackView.frame = CGRect(
            x: 0,
            y: view.heightExt - view.safeAreaInsets.bottom - 60,
            width: view.widthExt,
            height: Constants.buttonHeight
        )
        
        termsButton.frame = CGRect(
            x: 0,
            y: 0,
            width: stackView.widthExt / 2,
            height: Constants.buttonHeight
        )
        
        privacyButton.frame = CGRect(
            x: 0,
            y: 0,
            width: stackView.widthExt / 2,
            height: Constants.buttonHeight
        )
        
        configureHeaderView()
    }
    
    
    //MARK: - METHODS
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else { return }
        
        guard let backgroundView = headerView.subviews.first else { return }
        backgroundView.frame = headerView.bounds
        
        //Add image logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(
            x: headerView.widthExt/4.0,
            y: view.safeAreaInsets.top,
            width: headerView.widthExt/2.0,
            height: headerView.heightExt - view.safeAreaInsets.top
        )
    }
    
    private func addSubViews() {
        view.addSubview(headerView)
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(stackView)
    }
    
    //MARK: - Login functionality
    
    @objc private func didTapLoginButton() {
        passwordField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        
        guard let usernameEmail = userNameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                  return
              }
    }
    
    @objc private func didTapTermsButton() {
        guard let url = URL(string: Constants.termsUrl) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: Constants.policyUrl) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        present(vc, animated: true)
    }
    
}

//MARK: - EXTENSION

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}
