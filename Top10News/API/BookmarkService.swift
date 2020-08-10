//
//  BookmarkService.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/7/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation
import Firebase

struct BookmarkService {
    static let shared = BookmarkService()
    
    func uploadBookmark(withTitle title: String, withDescription description: String, withArticleURL url: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = [
            "uid": uid,
            "title": title,
            "description": description,
            "url": url,
            "timestamp": Int(NSDate().timeIntervalSince1970)
        ] as [String: Any]
        
        let ref = REF_BOOKMARKS.childByAutoId()
        
        ref.updateChildValues(values) { (error, reference) in
            guard let bookmarkID = ref.key else { return }
            REF_USER_BOOKMARKS.child(uid).updateChildValues([bookmarkID: 1], withCompletionBlock: completion)
        }
    }
    
    func fetchBookmarks(completion: @escaping([Bookmark]) -> Void) {
        var bookmarks = [Bookmark]()
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_BOOKMARKS.child(currentUID).observe(.childAdded) { snapshot in
            let bookMarkID = snapshot.key
            
            self.fetchBookmark(withBookmarkID: bookMarkID) { bookmark in
                bookmarks.append(bookmark)
                completion(bookmarks)
            }
        }
    }
    
    func fetchBookmark(withBookmarkID bookmarkID: String, completion: @escaping(Bookmark) -> Void) {
        REF_BOOKMARKS.child(bookmarkID).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
        
            UserService.shared.fetchUser(uid: uid) { user in
                let bookmark = Bookmark(user: user, bookmarkID: bookmarkID, dictionary: dictionary)
                completion(bookmark)
            }
        }
    }
    
    func delteBookmark(withBookmarkId id: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let bookmarkRef = REF_BOOKMARKS
        bookmarkRef.child(id).removeValue()
        
        let userBookmarkRef = REF_USER_BOOKMARKS
        userBookmarkRef.child(uid).child(id).removeValue(completionBlock: completion)
        
    }
    
    func showError(withErrorType errorType: String) -> UIAlertController {
            let ac = UIAlertController(title: "Loading Error", message: "There was a problem \(errorType) your bookmarks; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default))
            
            return ac
    }
}

