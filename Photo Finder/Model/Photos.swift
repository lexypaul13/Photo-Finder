//
//  Photos.swift
//  Photo Finder
//
//  Created by Alex Paul on 2/5/21.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

struct Photos: Codable {
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var promotedAt: String?
    var width: Int?
    var height: Int?
    var color: String?
    var blurHash: String?
    var photoDescription: String?
    var altDescription: String?
    var urls: Urls?
    var likes: Int?
    var likedByUser: Bool?
    var user: User?

}

// MARK: - User
struct User:Codable {
    var id: String?
    var updatedAt: String?
    var username: String?
    var name: String?
    var firstName: String?
    var lastName: String?
    var twitterUsername: String?
    var portfolioURL: String?
    var bio: String?
    var location: String?
    var instagramUsername: String?
    var totalCollections: Int?
    var totalLikes: Int?
    var totalPhotos: Int?
    var acceptedTos: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case updatedAt = "updated_at"
        case username = "username"
        case name = "name"
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio = "bio"
        case location = "location"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
    }
}

// MARK: - Urls
struct Urls: Codable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?

    enum CodingKeys: String, CodingKey {
        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }
}
typealias Photo = [Photos]
