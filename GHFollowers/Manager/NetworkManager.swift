//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    private let baseUrl = "https://api.github.com/users"
    
    private init() { }
    
    func getUser(for username: String) async throws -> User {
        guard let url = URL(string: "\(baseUrl)/\(username)") else {
            throw GFNetworkErrors.invalidResponse
        }
        return try await self.fetch(url: url)
    }
    
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        guard let url = URL(string: "\(baseUrl)/\(username)/followers?per_page=100&page=\(1)") else { throw GFNetworkErrors.invalidResponse }
        return try await self.fetch(url: url)
    }
    
    private func fetch<T: Codable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw GFNetworkErrors.invalidResponse
        }
        do {
            print(data as Any)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let item = try decoder.decode(T.self, from: data)
            return item
        } catch {
            throw GFNetworkErrors.decodingError
        }
    }
}

enum GFNetworkErrors: CustomNSError {
    case invalidResponse, decodingError
}
