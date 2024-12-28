//
//  User.swift
//  Gibigram
//
//  Created by Mert Ziya on 21.12.2024.
//

import Foundation

struct User: Codable{
    
    let uid: String?
    let email: String?
    let username: String?
    let fullname : String?
    let password: String?
    let summary : String?
    let profileImageURL : String?
    let posts : [String]? // contains the ids of the posts.
    let stories : [String]?
    let followings : [User]?
    let followers : [User]?
}
