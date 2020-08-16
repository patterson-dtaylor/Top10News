//
//  UpdateUserProfileController.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/14/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage


class UpdateUserProfileController: UIViewController {
    //MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var updatedProfileImage: UIImage?
    
    var user: User? {
        didSet {
            configProfileImage()
        }
    }
    
    private let editProfileImageAndUsernameText: UILabel = {
        let label = UILabel()
        label.text = "Edit your profile image and/or username!"
        label.textColor = UIColor(named: blackText)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 150 / 2
        iv.layer.backgroundColor = UIColor.systemPink.cgColor
        iv.layer.borderColor = UIColor.systemPink.cgColor
        iv.layer.borderWidth = 4
        
        let tapGesture  = UITapGestureRecognizer(target: self, action: #selector(addProfileButtonTapped))
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true

        return iv
    }()
    
    private let editProfileImageSymbol: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 35 / 2
        iv.layer.backgroundColor = UIColor.systemPink.cgColor
        iv.layer.borderColor = UIColor.systemPink.cgColor
        iv.layer.borderWidth = 1
        iv.image = UIImage(systemName: "pencil.circle.fill")
        iv.tintColor = .systemGray6
        return iv
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: UIColor(named: blackText)!, withImage: "person.fill", textField: usernameTextField)
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor(named: blackText)
        tf.font = UIFont.systemFont(ofSize: 19)
        tf.autocorrectionType = .no
        return tf
    }()
    
    private let saveChangedButton: UIButton = {
        let button = Utilities().pressedButtons(
            withTitle: "Save Changes",
            withTitleColor: .white,
            withFontSize: 21,
            withCornerRadius: 25
        )
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(saveChangesButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func addProfileButtonTapped() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func saveChangesButtonTapped() {
        guard let uid = user?.uid else { return }
        guard let updatedUserProfileImage = profileImage.image else { return }
        var updatedUsername = ""
        
        if usernameTextField.text != user?.username {
            guard let username = usernameTextField.text else { return }
            updatedUsername = username
        } else {
            guard let username = user?.username else { return }
            updatedUsername = username
        }
        
        AuthService.shared.updatedUserData(withUserUID: uid, withProfileImage: updatedUserProfileImage, withUsername: updatedUsername) { (error, ref) in
            print("DEBUG: Successfully updated user info!!!")
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            
            guard let tab = window.rootViewController as? MainTabController else { return }
            
            tab.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - API
    
    func fetchUser() {
        UserService.shared.fetchUsers { user in
            self.user = user
        }
    }
    
    //MARK: - Helpers
    
    func configProfileImage(){
        guard let user = user else { return }
    
        guard let profileImageURL = URL(string: user.profileImage) else { return }
        
        profileImage.sd_setImage(with: profileImageURL, completed: nil)
        usernameTextField.attributedPlaceholder = NSAttributedString(string: user.username, attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: grayText)!])
        
    }
    
    func configureUI() {
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(editProfileImageAndUsernameText)
        editProfileImageAndUsernameText.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40)
        
        view.addSubview(profileImage)
        profileImage.centerX(inView: view, topAnchor: editProfileImageAndUsernameText.bottomAnchor, paddingTop: 80)
        profileImage.setDimensions(width: 150, height: 150)
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        view.addSubview(editProfileImageSymbol)
        editProfileImageSymbol.anchor(
            top: profileImage.bottomAnchor,
            right: profileImage.rightAnchor,
            paddingTop: -50,
            paddingLeft: 90,
            width: 35,
            height: 35
        )
        
        view.addSubview(usernameContainerView)
        usernameContainerView.anchor(
            top: profileImage.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 80,
            paddingLeft: 50,
            paddingRight: 50
        )
        
        view.addSubview(saveChangedButton)
        saveChangedButton.setDimensions(width: 200, height: 50)
        saveChangedButton.centerX(inView: view, topAnchor: usernameContainerView.bottomAnchor, paddingTop: 80)
        
    }
}

extension UpdateUserProfileController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let updatedProfileImage = info[.editedImage] as? UIImage else { return }
        self.updatedProfileImage = updatedProfileImage
        
        self.profileImage.image = updatedProfileImage.withRenderingMode(.alwaysOriginal)
        
        dismiss(animated: true, completion: nil)
    }
}
