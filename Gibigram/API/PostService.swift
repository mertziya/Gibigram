//
//  PostService.swift
//  Gibigram
//
//  Created by Mert Ziya on 25.12.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


enum ErrorType: Error{
    case userIDerror
}

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
    
    static func uploadPost(post: Post, completion: @escaping (Result<String, Error>) -> Void) {
        let documentID = post.postID ?? UUID().uuidString
        let userID = Auth.auth().currentUser!.uid
        
        // Fetch the current user data
        Firestore.firestore().collection("users").document(userID).getDocument(as: User.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error)) // Fail early if fetching user data fails
            case .success(let currentUserData):
                // Construct the data dictionary after fetching the user data
                let data: [String: Any] = [
                    "postID": documentID,
                    "userID": userID,
                    "postLocation": post.postLocation ?? "",
                    "postImageURL": post.postImageURL ?? "",
                    "postDescription": post.postDescription ?? "",
                    "postComments": [[:]],
                    "postLikes": post.postLikes ?? 0,
                    
                    // User-related data
                    "username": currentUserData.username ?? "",
                    "fullname": currentUserData.fullname ?? "",
                    "profileImageURL": currentUserData.profileImageURL ?? ""
                ]
                
                // Upload the post
                let postDocument = Firestore.firestore().collection("posts")
                postDocument.document(documentID).setData(data) { error in
                    if let error = error {
                        completion(.failure(error)) // Fail if setting data fails
                    } else {
                        completion(.success(documentID)) // Success, return document ID
                    }
                }
            }
        }
    }
    
    static func addPostToCurrentUser(postID : String , completion : @escaping (Error?) -> () ){
        guard let currentUID = Auth.auth().currentUser?.uid else{
            completion(ErrorType.userIDerror)
            return
        }
        
        let currentUserDocument = Firestore.firestore().collection("users").document(currentUID)
        currentUserDocument.updateData(["posts" : FieldValue.arrayUnion([postID])]) { error in
            if let error = error {
                print("DEBUG: Error while adding data to user collection")
                completion(error)
            }else{
                completion(nil)
            }
        }
    }
    
    static func fetchPostsOfFollowedUsers(completion: @escaping (Result<[Post]?, Error>) -> ()) {
        guard let currentUID = Auth.auth().currentUser?.uid else {
            return
        }
        let userCollection = Firestore.firestore().collection("users")
        let postCollection = Firestore.firestore().collection("posts")
        
        userCollection.document(currentUID).getDocument(as: User.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let user):
                guard let followingsUserIDs = user.followings, !followingsUserIDs.isEmpty else {
                    completion(.success(nil))
                    return
                }
                
                var posts: [Post] = []
                let dispatchGroup = DispatchGroup() // To synchronize asynchronous calls
                
                for id in followingsUserIDs {
                    dispatchGroup.enter()
                    userCollection.document(id).getDocument(as: User.self) { result in
                        switch result {
                        case .failure(let error):
                            dispatchGroup.leave()
                            completion(.failure(error))
                            return
                        case .success(let followedUser):
                            guard let postIDs = followedUser.posts else {
                                dispatchGroup.leave()
                                return
                            }
                            
                            for postID in postIDs {
                                dispatchGroup.enter()
                                postCollection.document(postID).getDocument(as: Post.self) { result in
                                    switch result {
                                    case .failure(let error):
                                        dispatchGroup.leave()
                                        completion(.failure(error))
                                        return
                                    case .success(let post):
                                        posts.append(post)
                                        dispatchGroup.leave()
                                    }
                                }
                            }
                            dispatchGroup.leave() // THIS PART
                        }
                    }
                }
                
                dispatchGroup.notify(queue: .main) { // THIS PART
                    completion(.success(posts))
                }
            }
        }
    }
    
}
