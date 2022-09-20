//
//  User.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import Foundation

struct User: Codable {
    let login: String
    let name, location, twitterUsername, email, bio, avatarUrl, htmlUrl, followersUrl, followingUrl: String?
    let publicRepos, publicGists, followers, following: Int?
}
