//
//  GFNetworkErrors.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import Foundation

enum GFNetworkErrors: String, Error {
    case invalidResponse = "Check the username. Please, try again."
    case decodingError = "Decoding Error."
}
