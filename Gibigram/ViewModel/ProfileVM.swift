//
//  ProfilePostViewModel.swift
//  Gibigram
//
//  Created by Mert Ziya on 25.12.2024.
//

import Foundation


protocol ProfileViewModelDelegate: AnyObject {
    func didFetchPostsOfUser(_ posts: [Post])
    func didFetchStoriesOfUser(_ stories: [Story])
    func didFailWithError(_ error: Error)
}

class ProfileVM {
    
    weak var delegate: ProfileViewModelDelegate?
    
    func fetchPostsOfCurrentUser(){
        PostService.fetchPostsOfCurrentUser { result in
            switch result{
            case .failure(let error):
                self.delegate?.didFailWithError(error)
            case .success(let posts):
                self.delegate?.didFetchPostsOfUser(posts)
            }
        }
    }
    
    func fetchStoriesOfCurrentUser(){
        StoryService.fetchStoriesOfCurrentUser { result in
            switch result{
            case .failure(let error):
                self.delegate?.didFailWithError(error)
            case .success(let stories):
                self.delegate?.didFetchStoriesOfUser(stories)
            }
        }
    }
    
}
