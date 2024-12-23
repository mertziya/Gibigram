//
//  UserService.swift
//  Gibigram
//
//  Created by Mert Ziya on 23.12.2024.
//

import Foundation


import FirebaseAuth
import FirebaseFirestore

struct UserService{
    
    static func fetchUser(completion: @escaping (User?) -> () ) {
        guard let uid = Auth.auth().currentUser?.uid else{return}
        let userCollection = Firestore.firestore().collection("users")
        userCollection.document(uid).getDocument(as: User.self) { result in
            switch result{
            case .failure(let error):
                print("DEBUG: user cannot be fetched -> \(error.localizedDescription)")
                completion(nil)
            case .success(let user):
                completion(user)
            }
        }
    }
    
    // adds the image URL to the current user's image URL field. If it cannot it returns error in the closure.
    static func addProfileImageURL(url : String , completion: @escaping (Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "AuthError", code: -1, userInfo: ["description" : "no user loged in"]))
            return
        }
        
        let userCollection = Firestore.firestore().collection("users")
        
        userCollection.document(uid).setData(["profileImageURL" : url], merge: true) { error in
            if let error = error {
                completion(error)
            }else{
                completion(nil)
            }
        }
        
        
    }
}
