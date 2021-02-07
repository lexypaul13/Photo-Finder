//
//  Photos.swift
//  Photo Finder
//
//  Created by Alex Paul on 2/5/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photos = try? newJSONDecoder().decode(Photos.self, from: jsonData)

import Foundation

// MARK: - Photos
struct Photos: Codable {
    var instructions: [Instruction]?
}

// MARK: - Instruction
struct Instruction: Codable {
    var id: String?
    var createdAt: Date?
    var urls: Urls?
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case urls
    }
}

// MARK: - Urls
struct Urls: Codable {
    var full, thumb: String?
    var user: User?
}

// MARK: - User
struct User: Codable {
    var username, name: String?
}
