//
//  RegistrationController.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/26/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let addProfileImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "addImage"), for: .normal)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(addProfileButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: UIColor(named: blackText)!, withImage: "person.fill", textField: usernameTextField)
        
        return view
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
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Username")
        
        return tf
    }()
    
    private let registerButton: UIButton = {
        let button = Utilities().pressedButtons(
            withTitle: "Register",
            withTitleColor: .white,
            withFontSize: 21,
            withCornerRadius: 25
        )
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log in Now!")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    @objc func addProfileButtonTapped() {
        present(imagePicker, animated: true)
    }
    
    @objc func registerButtonTapped() {
        
        var username = ""
        var email = ""
        var password = ""
        
        guard let profileImage = profileImage else {
            
            let ac = Utilities().registrationAlterAction(
                withControllerTitle: "Oops...",
                withMessage: "You must select a profile image.",
                withActionTitle: "Ok"
            )
            
            present(ac, animated: true, completion: nil)
            
            return
        }
        
        guard let safeUsername = usernameTextField.text?.lowercased() else { return }
        
        if safeUsername.count < 6 {
            let ac = Utilities().registrationAlterAction(
                withControllerTitle: "Darn...",
                withMessage: "Your username must be more than 6 characters long.",
                withActionTitle: "Ok"
            )
            
            present(ac, animated: true, completion: nil)
            
        } else {
            username = safeUsername
        }
        
        print("DEBUG: User username is \(username).")
        
        guard let safeEmail = emailTextField.text else { return }
    
        let isAValidEmailAddress = Utilities().isValidEmailAddress(emailAddressString: safeEmail)
        
        if isAValidEmailAddress {
            email = safeEmail
        } else {
            let ac = Utilities().registrationAlterAction(
                withControllerTitle: "Aww, man...",
                withMessage: "Your email must be a valid email address.",
                withActionTitle: "Ok"
            )
            
            present(ac, animated: true, completion: nil)
        }
        
        print("DEBUG: User email is \(email).")
        
        guard let safePassword = passwordTextField.text else { return }
        
        let isValidPassword = Utilities().isValidPassword(passwordString: safePassword)
        
        if isValidPassword {
            password = safePassword
        } else {
            let ac = Utilities().registrationAlterAction(
                withControllerTitle: "Bummer...",
                withMessage: "Your password must have at least 1 uppercase character, 1 digit, 1 lowercase character, and 8 characters total.",
                withActionTitle: "Ok"
            )
            
            present(ac, animated: true, completion: nil)
        }
        
        print("DEBUG: User password is \(password).")
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                let ac = Utilities().registrationAlterAction(
                    withControllerTitle: "Oh no...",
                    withMessage: "Error: \(error.localizedDescription)",
                    withActionTitle: "Ok"
                )
                
                self.present(ac, animated: true, completion: nil)
            }
            
            print("DEBUG: Successfully created user!!!")
        }
        
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(addProfileImageButton)
        addProfileImageButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 100)
        addProfileImageButton.setDimensions(width: 150, height: 150)
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        let stack = UIStackView(arrangedSubviews: [usernameContainerView, emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.spacing = 30
        
        view.addSubview(stack)
        stack.anchor(top: addProfileImageButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50)
        
        view.addSubview(registerButton)
        registerButton.anchor(
            top: stack.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 30,
            paddingLeft: 40,
            paddingRight: 40,
            width: 334,
            height: 50
        )
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 40,
            paddingBottom: 20,
            paddingRight: 30,
            width: 228,
            height: 16
        )
    }
    
}

extension RegistrationController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        addProfileImageButton.layer.cornerRadius = 150 / 2
        addProfileImageButton.layer.masksToBounds = true
        addProfileImageButton.imageView?.contentMode = .scaleAspectFill
        addProfileImageButton.imageView?.clipsToBounds = true
        
        self.addProfileImageButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
