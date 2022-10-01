//
//  Follower.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String?
}

extension Follower {
    var imageUrl: URL? {
        guard let avatarUrl else { return nil }
        return URL(string: avatarUrl)
    }
}
