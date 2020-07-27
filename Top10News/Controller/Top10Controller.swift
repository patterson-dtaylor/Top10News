//
//  Top10Controller.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/25/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class Top10Controller: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "top10NavBar"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }

}
