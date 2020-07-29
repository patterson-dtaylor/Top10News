//
//  HomeController.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/25/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import SDWebImage

class HomeController: UIViewController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            configureUserProfileImage()
        }
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Saturday, July 25"
        label.font = UIFont(name: ralewayRegular, size: 20)
        label.tintColor = UIColor(named: grayText)
        
        return label
    }()
    
    let todayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Today"
        label.font = UIFont(name: loraBold, size: 26)
        label.tintColor = UIColor(named: blackText)
        
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 50, height: 50)
        iv.layer.cornerRadius = 50 / 2
        iv.layer.backgroundColor = UIColor.systemPink.cgColor

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true

        return iv
    }()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isUserInteractionEnabled = true
        
        configureUI()

    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        AuthService.shared.signOut()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.isNavigationBarHidden = true
//        navigationController?.navigationBar.backgroundColor = .white
//        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
//        let labelStack = UIStackView(arrangedSubviews: [dateLabel, todayLabel])
//        labelStack.axis = .vertical
//        labelStack.spacing = 4
//
//        let stack = UIStackView(arrangedSubviews: [labelStack, profileImage])
//        stack.axis = .horizontal
//        stack.alignment = .center
//        stack.distribution = .equalSpacing
//        view.addSubview(stack)
//        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingRight: 20)
        
    }
    
    func configureUserProfileImage() {
        guard let user = user else { return }
        
        let labelStack = UIStackView(arrangedSubviews: [dateLabel, todayLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 4
        
        let stack = UIStackView(arrangedSubviews: [labelStack, profileImage])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingRight: 20)

        guard let profileImageURL = URL(string: user.profileImage) else { return }
        profileImage.sd_setImage(with: profileImageURL, completed: nil)
    }

}
