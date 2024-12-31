//
//  HomeVM.swift
//  Gibigram
//
//  Created by Mert Ziya on 30.12.2024.
//

import Foundation

protocol HomeVMDelegate : AnyObject {
    func didFailWithError(error: Error)
    func didFetchTargetedPosts(posts : [Post]?)
}

class HomeVM{
    
    var delegate : HomeVMDelegate?
    
    func getPostsForTable(){
        PostService.fetchPostsOfFollowedUsers { result in
            switch result{
            case .failure(let error): self.delegate?.didFailWithError(error: error)
            case .success(let posts):
                self.delegate?.didFetchTargetedPosts(posts: posts)
            }
        }
    }
    
}
