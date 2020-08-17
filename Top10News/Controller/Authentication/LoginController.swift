//
//  LoginController.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/26/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "logo")
        
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: UIColor(named: blackText)!, withImage: "envelope.fill", textField: emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: UIColor(named: blackText)!, withImage: "lock.fill", textField: passwordTextField)
        
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Email")
        
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = Utilities().pressedButtons(
            withTitle: "Login",
            withTitleColor: .white,
            withFontSize: 21,
            withCornerRadius: 25
        )
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = Utilities().attributedButton("Forgot password?", " Click here!")
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", " Sign Up Now!")
        button.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    @objc func loginButtonTapped() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(withEmail: email, withPassword: password) { (result, error) in
            if let error = error {
            let ac = Utilities().registrationAlterAction(
                withControllerTitle: "Oh no...",
                withMessage: "Error: \(error.localizedDescription)",
                withActionTitle: "Ok"
            )
            
            self.present(ac, animated: true, completion: nil)
        }
            
            print("DEBUG: Successfully signed in user!!!")
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

            guard let tab = window.rootViewController as? MainTabController else { return }

            tab.authenticateUserAndConfigureUI()

            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleForgotPassword() {
        forgotPassword()
    }
    
    @objc func handleShowRegistration() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.setDimensions(width: 200, height: 200)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(
            top: logoImageView.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 20
        )
        
        view.addSubview(loginButton)
        loginButton.anchor(
            top: stack.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 30,
            paddingLeft: 40,
            paddingRight: 40,
            width: 334,
            height: 50
        )
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.setDimensions(width: 200, height: 16)
        forgotPasswordButton.centerX(inView: view, topAnchor: loginButton.bottomAnchor, paddingTop: 30)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 40,
            paddingBottom: 20,
            paddingRight: 40,
            width: 228,
            height: 16
        )
    }
    
    func forgotPassword(){
        
        let ac = UIAlertController(title: "Forgot password?", message: "Enter your email.", preferredStyle: .alert)
        ac.addTextField { (textfield) in
            textfield.placeholder = "Email"
            textfield.textColor = .gray
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        ac.addAction(UIAlertAction(title: "Send password", style: .default, handler: { (action) in
            guard let email = ac.textFields?[0].text else { return }
            
            if email != "" {
                AuthService.shared.forgotPassword(withEmail: email) { (error) in
                    if let error = error {
                        let ac = AuthService.shared.showPasswordError(withError: error)
                        self.present(ac, animated: true, completion: nil)
                    }
                }
            } else {
                let ac = UIAlertController(title: "Error", message: "Email cannot be blank!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                self.present(ac, animated: true, completion: nil)
            }
            
        }))
        
        present(ac, animated: true, completion: nil)
    }
}
