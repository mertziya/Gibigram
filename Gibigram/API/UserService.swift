//
//  UserService.swift
//  Gibigram
//
//  Created by Mert Ziya on 23.12.2024.
//

import Combine
import FirebaseAuth
import FirebaseFirestore

struct UserService{

    static func fetchCurrentUser() -> Future<User?, Never>{
         return Future { promise in
             guard let uid = Auth.auth().currentUser?.uid else{
                 promise(.success(nil))
                 return
             }
             
             let userCollection = Firestore.firestore().collection("users")
             userCollection.document(uid).getDocument(as: User.self) { result in
                 switch result {
                 case .failure(let error):
                     print("DEBUG: user cannot be fetched")
                     promise(.success(nil))
                 case .success(let user):
                     promise(.success(user))
                 }
             }
         }
    }

  

    
    
    
    static func updateUsername(withNew: String, completion: @escaping(Result<Void,Error>) -> ()){
        guard let currentUid = Auth.auth().currentUser?.uid else {print("nil uid") ; return }
        Firestore.firestore().collection("users").document(currentUid).updateData(["username" : withNew]) { error in
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(()))
            }
        }
    }
    static func updateFullname(withNew: String, completion: @escaping(Result<Void,Error>) -> ()){
        guard let currentUid = Auth.auth().currentUser?.uid else {print("nil uid") ; return }
        Firestore.firestore().collection("users").document(currentUid).updateData(["fullname" : withNew]) { error in
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(()))
            }
        }
    }
    static func updateSummary(withNew: String, completion: @escaping(Result<Void,Error>) -> ()){
        guard let currentUid = Auth.auth().currentUser?.uid else {print("nil uid") ; return }
        Firestore.firestore().collection("users").document(currentUid).updateData(["summary" : withNew]) { error in
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(()))
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
    
    static func updateUser(){
        
    }
}
