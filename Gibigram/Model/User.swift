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
    let posts : [Post]?
    let stories : [Story]?
    let followings : [User]?
    let followers : [User]?
}
