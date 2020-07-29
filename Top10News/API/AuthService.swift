//
//  AuthService.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/28/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredentials {
    let profileImage: UIImage
    let username: String
    let email: String
    let password: String
}

struct AuthService {
    static let shared = AuthService()
    let registrationController = RegistrationController()
    
    func logUserIn(withEmail email: String, withPassword password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(withCredientials credientials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let imageData = credientials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGE.child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { (meta, err) in
            storageRef.downloadURL { (url, err) in
                if let error = err {
                    self.registrationController.showError(error: error)
                }
                
                guard let profileImageURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credientials.email, password: credientials.password) { (result, err) in
                    if let error = err {
                        self.registrationController.showError(error: error)
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let values = [
                        "profileImageURL": profileImageURL,
                        "username": credientials.username,
                        "email": credientials.email
                    ]
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                        
                }
                
            }
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
}
