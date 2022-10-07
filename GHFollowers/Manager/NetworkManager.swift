//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
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
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let item = try decoder.decode(T.self, from: data)
            return item
        } catch {
            throw GFNetworkErrors.decodingError
        }
    }
    
    func downloadImage(from url: URL?) async -> UIImage? {
        guard let url else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)
            return image
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
