//
//  StoryCellVM.swift
//  Gibigram
//
//  Created by Mert Ziya on 30.12.2024.
//

import Foundation

protocol StoryCellVMDelegate: AnyObject{
    func didFetchStories(stories: [Story]?)
    func didFailWithError(error: Error)
}

class StoryCellVM{
    
    weak var delegate : StoryCellVMDelegate?
    
    func fetchStoriesOfFollowedUser(){
        StoryService.fetchStoriesOfFollowedUser { result in
            switch result{
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            case .success(let stories):
                self.delegate?.didFetchStories(stories: stories)
            }
        }
    }
    
}
