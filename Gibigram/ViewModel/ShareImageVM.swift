//
//  ShareImageVM.swift
//  Gibigram
//
//  Created by Mert Ziya on 30.12.2024.
//

import Foundation
import UIKit


class ShareImageVM{
    
    func loadPost(selectedImage: UIImage, postDescription: String, postLocation: String ){
        let imageUploader = ImageUploader()
        var postToUpload = Post()
        var IDofPost : String = ""
        
        // !! -- I AM SORRY FOR THE NESTED CLOSURES -- !!
        imageUploader.uploadImage(image: selectedImage) { imageURL in
            postToUpload.postImageURL = imageURL
            postToUpload.postDescription = postDescription
            postToUpload.postLocation = postLocation
            PostService.uploadPost(post: postToUpload) { result in
                switch result{
                case .failure(let error):
                    print("DEBUG: \(error.localizedDescription)")
                case .success(let postID):
                    IDofPost = postID
                    PostService.addPostToCurrentUser(postID: IDofPost) { error in
                        if let error = error{
                            print("DEBUG: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
    
    func loadStory(selectedImage : UIImage, storyDescription: String){
        let imageUploader = ImageUploader()
        
        imageUploader.uploadImage(image: selectedImage) { imageURL in
            var story = Story()
            story.storyImageURL = imageURL
            story.storyDescription = storyDescription
            StoryService.uploadStory(story: story) { result in
                switch result{
                case .failure(let error):
                    print("DEBUG: ShareImageVM, \(error.localizedDescription)")
                case .success(let storyID):
                    StoryService.addStoryToCurrentUser(storyID: storyID) { error in
                        if let error = error{
                            print("DEBUG, ShareImageVM : \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
    
}
