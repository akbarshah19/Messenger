//
//  LoginViewController.swift
//  Messenger
//
//  Created by Akbarshah Jumanazarov on 7/6/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.clipsToBounds = true
        return view
    }()
    
    private let logo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        addSubviews()
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(logo)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/4
        logo.frame = CGRect(x: (scrollView.width - size)/2, y: 20, width: size, height: size)
        emailField.frame = CGRect(x: 15, y: logo.bottom + 40, width: scrollView.width - 30, height: 52)
        passwordField.frame = CGRect(x: 15, y: emailField.bottom + 10, width: scrollView.width - 30, height: 52)
        loginButton.frame = CGRect(x: 15, y: passwordField.bottom + 10, width: scrollView.width - 30, height: 52)
    }
    
    @objc private func didTapLogin() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 6 else {
            alertLoginUserError()
            return
        }
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func alertLoginUserError() {
        let alert = UIAlertController(title: "Empty email or password, check and try again.", message: "Password should be at least 6 chars.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it!", style: .cancel))
        present(alert, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLogin()
        }
        return true
    }
}
