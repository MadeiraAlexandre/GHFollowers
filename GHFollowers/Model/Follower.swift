//
//  Follower.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
    private enum CodingKeys: String, CodingKey { case login, avatarUrl }
    var uuid = UUID().uuidString
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

extension Follower {
    var imageUrl: URL? {
        return URL(string: avatarUrl)
    }
}
