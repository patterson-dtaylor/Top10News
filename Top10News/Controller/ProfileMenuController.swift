//
//  ProfileMenuController.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/11/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import Firebase

class ProfileMenuController: UIViewController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            configureUserProfileImage()
        }
    }
    
    lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 125 / 2
        iv.layer.backgroundColor = UIColor.systemPink.cgColor
        iv.layer.borderColor = UIColor.systemPink.cgColor
        iv.layer.borderWidth = 4

        return iv
    }()
    
    private let editProfileButton: UIButton = {
        let button = Utilities().pressedButtons(
            withTitle: "Edit Profile",
            withTitleColor: .white,
            withFontSize: 16,
            withCornerRadius: 8
        )
        button.backgroundColor = .systemPink
        button.setDimensions(width: 125, height: 30)
        button.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let signOutButton: UIButton = {
        let button = Utilities().pressedButtons(
            withTitle: "Sign Out",
            withTitleColor: .systemPink,
            withFontSize: 16,
            withCornerRadius: 8
        )
        button.backgroundColor = .systemGray6
        button.setDimensions(width: 125, height: 30)
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        configure()
    }
    
    //MARK: - Selector
    
    @objc func editProfileButtonTapped() {
        let controller = UpdateUserProfileController()
        present(controller, animated: true, completion: nil)
    }
    
    @objc func signOutButtonPressed() {
        signOut()
    }
    
    //MARK: - API
    
    func fetchUser() {
        UserService.shared.fetchUsers { user in
            self.user = user
        }
    }
    
    //MARK: - Helpers
    
    func configure() {
        view.addSubview(profileImage)
        profileImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 100)
        profileImage.setDimensions(width: 125, height: 125)
        
        let buttonStack = UIStackView(arrangedSubviews: [editProfileButton, signOutButton])
        view.addSubview(buttonStack)
        buttonStack.axis = .vertical
        buttonStack.spacing = 20
        buttonStack.centerX(inView: view, topAnchor: profileImage.bottomAnchor, paddingTop: 50)
        
    }
    
    func configureUserProfileImage() {
        guard let user = user else { return }

        guard let profileImageURL = URL(string: user.profileImage) else { return }
        profileImage.sd_setImage(with: profileImageURL, completed: nil)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            let vc = LoginController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        } catch let error {
            let ac = UIAlertController(title: "Error", message: "There was an erro signing out: \(error.localizedDescription)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        }
    }
    
}
