//
//  RedditModel.swift
//  BunnyWatch
//
//  Created by Mar Cabrera on 25/12/2023.
//

import Foundation

struct RedditModel: Codable {
    let data: ChildrenPosts
}

struct ChildrenPosts: Codable {
    let children: [ChildPost]
}

struct ChildPost: Codable {
    let data: Data
}

struct Data: Codable {
    let id: String
    let authorFullName: String
    let title: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case authorFullName = "author_fullname"
        case title = "title"
    }
}
