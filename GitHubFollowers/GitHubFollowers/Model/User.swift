//
//  User.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 2.04.2024.
//

import Foundation

struct User: Codable{
    let login       : String
    let avatarUrl   : String
    var name        : String?
    var location    : String?
    var bio         : String?
    let publicRepo  : Int
    let publicGist  : Int
    let htmlUrl     : String
    let following   : Int
    let followers   : Int
    let createdAt   : String
}
