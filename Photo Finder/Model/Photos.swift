//
//  Photos.swift
//  Photo Finder
//
//  Created by Alex Paul on 2/5/21.
//

import Foundation

struct URLs: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}

struct User: Codable {
    var id: String
    var name: String
    var portfolio_url: String
    var bio: String
}

struct DataModel: Codable {
    var id: String
    var created_at: String
    var likes: Int
    var liked_by_user: Bool
    var description: String
    var urls: [URLs]
    var user: [User]
}
