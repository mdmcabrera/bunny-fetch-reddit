//
//  RedditDataFetcher.swift
//  BunnyWatch
//
//  Created by Mar Cabrera on 25/12/2023.
//

import Foundation

enum RedditFetcherError: Error {
    case invalidURL
}

class RedditDataFetcher {
    
    func fetch(from endpoint: String) async throws -> RedditModel {
        guard let url = URL(string: endpoint) else {
            throw RedditFetcherError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let result = try JSONDecoder().decode(RedditModel.self, from: data)
        
        print(result.data.children.last?.data.title)
        return result
    }
}
