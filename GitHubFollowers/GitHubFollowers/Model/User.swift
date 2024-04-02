//
//  User.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 2.04.2024.
//

import Foundation

struct User: Codable{
    var login       : String
    var avatarUrl   : String
    var name        : String?
    var location    : String
    var bio         : String?
    var publicRepo  : Int
    var publicGist  : Int
    var htmlUrl     : String
    var following   : Int
    var followers   : Int
    var createdAt   : String
}
