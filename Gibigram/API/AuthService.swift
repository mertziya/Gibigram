//
//  AuthService.swift
//  Gibigram
//
//  Created by Mert Ziya on 10.12.2024.
//

import FirebaseAuth
import FirebaseFirestore

import UIKit


struct AuthCredentials{
    let email : String
    let password : String
    let username : String
    let fullname : String
    let profileImage : UIImage?
}

struct AuthService{
    
    // MARK: - Firebase Authentication:
    static func registerUserFirebase(credentials : AuthCredentials , completion : @escaping (Error?) -> () ){
        
        ImageUploader().uploadImage(image: credentials.profileImage ?? UIImage(systemName: "person.fill")!) { imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error{
                    print("\n Failed to register User: " , error.localizedDescription)
                }
                
              
                
                guard let uid = result?.user.uid else {return}
                
                let data : [String : Any] = ["uid" : uid
                                             ,"email" : credentials.email
                                             ,"password" : credentials.password
                                             ,"username" :  credentials.username
                                             ,"fullname" : credentials.fullname
                                             ,"profileImageURL" : imageURL ?? "BAD URL"]
                
                Firestore.firestore().collection("users").document(uid).setData(data) { error in
                    if let error = error {
                        completion(error)
                    }else{
                        print("document created succesfully.")
                        completion(nil)
                    }
                }
                
            }
        }
    }
    
    
    static func loginUserFirebase(email : String, password: String, completion : @escaping (Error?) -> () ){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                completion(error)
            }else{
                completion(nil)
            }
        }
    }
    
    
}
