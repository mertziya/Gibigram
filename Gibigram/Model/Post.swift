//
//  Post.swift
//  Gibigram
//
//  Created by Mert Ziya on 23.12.2024.
//

import Foundation

struct Post : Codable {
    var postID : String?
    var userID : String?
    var postLocation : String?
    var postImageURL : String?
    var postDescription : String?
    var postComments : [[String:String]]?
    var postLikes : Int?
    
}
