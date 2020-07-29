//
//  User.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/28/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let email: String
    let profileImage: String
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImage = dictionary["profileImageURL"] as? String ?? ""
        
    }
}
