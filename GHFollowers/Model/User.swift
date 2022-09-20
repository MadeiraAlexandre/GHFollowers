//
//  User.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import Foundation

struct User: Codable {
    let id: Int
    let login, avatarURL, htmlUrl: String
    let name, location, twitterUsername, email, bio: String?
    let publicRepos, publicGists, followers, following: Int
}
