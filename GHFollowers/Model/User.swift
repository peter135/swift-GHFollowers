//
//  User.swift
//  GHFollowers
//
//  Created by apple on 2024/5/28.
//

import Foundation

struct User:Codable {
    let login:String
    let avatarUrl:String
    var name:String?
    var location:String?
    var bio:String?
    let publicRepos:Int
    let publicGists:Int
    let htmlUrl:String
    let following:Int
    let followers:Int
    let createdAt:Date
}
