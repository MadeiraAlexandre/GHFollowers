//
//  User.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import Foundation

struct User: Codable {
    let login: String
    var name, location, twitterUsername, email, bio, avatarUrl, htmlUrl, followersUrl, followingUrl: String?
    var publicRepos, publicGists, followers, following: Int?
}
