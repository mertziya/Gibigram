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
}
