//
//  AuthLogic.swift
//  Gibigram
//
//  Created by Mert Ziya on 21.12.2024.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials{
    let email : String
    let password : String
    let username : String
    let fullname : String
}

class AuthLogic {

    static func registerUser(with credentials : AuthCredentials , completion: @escaping (Error?) -> ()) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
            if let error = error {
                completion(error)
            }
            guard let uid = result?.user.uid else {return}
            
            let data : [String : Any] = ["uid" : uid
                                         ,"email" : credentials.email
                                         ,"username" :  credentials.username
                                         ,"fullname" : credentials.fullname
                                         ,"password" : credentials.password
                                         ,"summary" : ""
                                         ,"profileImageURL" : ""
                                         ,"posts" : [String]()
                                         ,"stories" : [String]()
                                         ,"followings" : [User]()
                                         ,"followers" : [User]()
            ]
            
            let users = Firestore.firestore().collection("users")
            users.document(uid).setData(data) { error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    completion(error)
                }else{
                    print("document created succesfully")
                    completion(nil)
                }
            }
            
        }
    }
    
    static func loginUser(email : String , password : String , completion : @escaping (Error?) -> () ){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
            }else{
                completion(nil)
            }
        }
    }
    
    
    
}
