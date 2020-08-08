//
//  Bookmark.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/7/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation

struct Bookmark {
    let uid: String
    let bookmarkID: String
    var user: User
    let title: String
    let description: String
    let url: String
    var timestamp: Date!
    
    init(user: User, bookmarkID: String, dictionary: [String: Any]) {
        self.bookmarkID = bookmarkID
        self.user = user
        self.uid = dictionary["uid"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.url = dictionary["url"] as? String ?? ""
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
    }
}
