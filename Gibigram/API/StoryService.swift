//
//  StoryService.swift
//  Gibigram
//
//  Created by Mert Ziya on 28.12.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore





class StoryService{
    static func fetchStoriesOfCurrentUser(completion: @escaping (Result<[Story],Error>) -> ()) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            print("DEBUG: Cannot get userID -> StoryService")
            return
        }
        print("DEBUG: Current UserID: \(currentUserId)")
        
        let currentUserDocument = Firestore.firestore().collection("users").document(currentUserId)
        currentUserDocument.getDocument(as: User.self) { result in
            switch result {
            case .failure(let error):
                print("DEBUG: Failed to fetch user document - \(error.localizedDescription)")
                completion(.failure(error))
            case .success(let user):
                print("DEBUG: Fetched user document: \(user)")
                guard let storyIDs = user.stories else {
                    print("DEBUG: No story IDs found for user")
                    completion(.success([]))
                    return
                }
                print("DEBUG: Story IDs: \(storyIDs)")
                
                var stories: [Story] = []
                let dispatchGroup = DispatchGroup()
                var fetchError: Error?
                
                for storyID in storyIDs {
                    dispatchGroup.enter()
                    print("DEBUG: Fetching story with ID: \(storyID)")
                    let storyDoc = Firestore.firestore().collection("stories").document(storyID)
                    storyDoc.getDocument(as: Story.self) { result in
                        switch result {
                        case .failure(let error):
                            print("DEBUG: Failed to fetch story with ID \(storyID) - \(error.localizedDescription)")
                            fetchError = error
                        case .success(let story):
                            print("DEBUG: Fetched story: \(story)")
                            stories.append(story)
                        }
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    if let error = fetchError {
                        print("DEBUG: At least one story fetch failed - \(error.localizedDescription)")
                        completion(.failure(error))
                    } else {
                        print("DEBUG: Successfully fetched \(stories.count) stories")
                        completion(.success(stories))
                    }
                }
            }
        }
    }
    
    
    static func uploadStory(story : Story, completion : @escaping (Result<String,Error>)->() ){
        let documentID = UUID().uuidString
        let currentUID = Auth.auth().currentUser?.uid
        let data : [String : Any] = [
            "storyID" : documentID,
            "userID" : currentUID ?? "",
            "storyImageURL" : story.storyImageURL ?? "",
            "storyDescription" : story.storyDescription ?? ""
        ]

        let collection = Firestore.firestore().collection("stories")
        collection.document(documentID).setData(data) { error in
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(documentID))
            }
        }
    }
    
    static func addStoryToCurrentUser(storyID : String, completion: @escaping (Error?) -> () ){
        guard let currentUID = Auth.auth().currentUser?.uid else{completion(ErrorType.userIDerror); return }
        let currentDoc = Firestore.firestore().collection("users").document(currentUID)
        
        currentDoc.updateData(["stories" : FieldValue.arrayUnion([storyID])]) { error in
            if let error = error{
                completion(error)
            }else{
                completion(nil)
            }
        }
    }
    
    static func fetchStoriesOfFollowedUser(completion: @escaping (Result<[Story]?,Error>) -> () ){
        guard let userid = Auth.auth().currentUser?.uid else{completion(.failure(ErrorType.userIDerror)) ; return}
        let userCollection = Firestore.firestore().collection("users")
        let storyCollection = Firestore.firestore().collection("stories")
        
        userCollection.document(userid).getDocument(as: User.self) { result in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let user):
                guard let followingUserIDs = user.followings , !followingUserIDs.isEmpty else {
                    completion(.success(nil))
                    return
                }
                
                var stories : [Story] = []
                let dispatchGroup = DispatchGroup()
                
                for followingID in followingUserIDs {
                    dispatchGroup.enter()
                    userCollection.document(followingID).getDocument(as: User.self) { result in
                        switch result{
                        case .failure(let error):
                            dispatchGroup.leave()
                            completion(.failure(error))
                            return
                        case .success(let followedUser):
                            guard let storiesIDArray = followedUser.stories else{
                                dispatchGroup.leave()
                                return
                            }
                            
                            for storyID in storiesIDArray{
                                dispatchGroup.enter() // Enter for each storyID
                                storyCollection.document(storyID).getDocument(as: Story.self) { result in
                                    switch result{
                                    case .failure(let error):
                                        completion(.failure(error))
                                    case .success(let story):
                                        stories.append(story)
                                    }
                                    dispatchGroup.leave() // Leave after story fetch
                                }
                            }
                            dispatchGroup.leave()
                        }
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion(.success(stories))
                }
            }
        }
    }
    
    
}
