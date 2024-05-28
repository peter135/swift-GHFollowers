//
//  User.swift
//  GHFollowers
//
//  Created by apple on 2024/5/28.
//

import Foundation

struct User:Codable {
    var login:String
    var avatarUrl:String
    var name:String?
    var location:String?
    var bio:String?
    var publicRepos:Int
    var publishGists:Int
    var htmlUrl:String
    var following:Int
    var followers:Int
    var createdAt:String
}
