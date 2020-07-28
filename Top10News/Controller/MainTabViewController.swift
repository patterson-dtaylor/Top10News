//
//  MainTabViewController.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/25/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import Firebase

class MainTabViewController: UITabBarController {
    
    //MARK: - Properties
    
    
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isUserInteractionEnabled = true
        
//        signOut()
        authenticateUserAndConfigureUI()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemPink], for: .selected)

    }
    
    //MARK: - API
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewContoller()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("DEBUG: Signed user out!!!")
        } catch let error {
          print ("Error signing out: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureViewContoller() {
        
        let home = templateNavigationController(withTabBarImage: "house.fill", withTabBarSelectedImage: "home", withTabBarTitle: "Home", withRootViewController: HomeController())
        
        let top10 = templateNavigationController(withTabBarImage: "list.number", withTabBarSelectedImage: "list", withTabBarTitle: "Top 10", withRootViewController: Top10Controller())
        
        let bookmark = templateNavigationController(withTabBarImage: "bookmark", withTabBarSelectedImage: "bookmark", withTabBarTitle: "Bookmarks", withRootViewController: BookmarkController())
        
        let explore = templateNavigationController(withTabBarImage: "magnifyingglass.circle.fill", withTabBarSelectedImage: "magnifyingGlass", withTabBarTitle: "Search", withRootViewController: ExploreController())
        
        viewControllers = [home, top10, bookmark, explore]
    }
    
    func templateNavigationController(withTabBarImage image: String, withTabBarSelectedImage selectedImage: String, withTabBarTitle: String, withRootViewController controller: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: controller)
        nav.tabBarItem.image = UIImage(systemName: image)
        nav.tabBarItem.selectedImage = UIImage(named: selectedImage)
        nav.tabBarItem.title = title
        
        return nav
    }

}
