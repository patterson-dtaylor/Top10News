//
//  ExploreController.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/25/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {
    
    //MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "logo")
        
        return iv
    }()
    
    private lazy var searchContainerView: UIView = {
        let view = Utilities().inputContainerView(withColor: UIColor(named: blackText)!, withImage: "magnifyingglass", textField: searchTextField)
        
        return view
    }()
    
    private var searchTextField: UITextField = {
        let tf = Utilities().inputTextField(withPlaceholder: "Topic(s)")
        
        return tf
    }()
    
    private let searchButton: UIButton = {
        let button = Utilities().pressedButtons(
            withTitle: "Search",
            withTitleColor: .white,
            withFontSize: 21,
            withCornerRadius: 25
        )
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(handleSearchFeed), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemGray6
        configureUI()

    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    @objc func handleSearchFeed() {
        guard var searchTF = searchTextField.text else { return }
        let searchURL = "https://newsapi.org/v2/everything?pageSize=10&q=\(searchTF)\(apiKey)"
        guard let url = searchURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let controller = ExploreFeedController(queryText: searchTF, queryURL: url)
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true, completion: nil)
        searchTextField.text = ""
        searchTF = ""
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.setDimensions(width: 200, height: 200)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 75)
        
        view.addSubview(searchTextField)
        searchTextField.centerX(inView: view, topAnchor: logoImageView.bottomAnchor, paddingTop: 50)
        
        view.addSubview(searchButton)
        searchButton.anchor(
            top: searchTextField.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 30,
            paddingLeft: 40,
            paddingRight: 40,
            width: 334,
            height: 50
        )
    }

}
