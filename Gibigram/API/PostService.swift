//
//  PostService.swift
//  Gibigram
//
//  Created by Mert Ziya on 25.12.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class PostService{
    static func fetchPostsOfCurrentUser(completion: @escaping (Result<[Post],Error>) -> () ){
        guard let currentUID = Auth.auth().currentUser?.uid else{print("DEBUG: can't have userID") ; return }
        let userDoc = Firestore.firestore().collection("users").document(currentUID)
        
        userDoc.getDocument(as: User.self) { result in
            switch result{
            case .failure(let error): completion(.failure(error))
            case .success(let user):
                guard let postIDs = user.posts, !postIDs.isEmpty else {
                    // Return an empty array if the user has no posts
                    completion(.success([]))
                    return
                }
                var posts : [Post] = []
                let dispatchGroup = DispatchGroup()
                var fetchError: Error?
            
                for postID in postIDs{
                    dispatchGroup.enter()
                    let postDoc = Firestore.firestore().collection("posts").document(postID)
                    postDoc.getDocument(as: Post.self) { result2 in
                        switch result2 {
                        case .failure(let error): fetchError = error
                        case .success(let post):
                            posts.append(post)
                        }
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    if let error = fetchError{
                        completion(.failure(error))
                    }else{
                        completion(.success(posts))
                    }
                }
            }
        }
    }
    
    
    
    
}
