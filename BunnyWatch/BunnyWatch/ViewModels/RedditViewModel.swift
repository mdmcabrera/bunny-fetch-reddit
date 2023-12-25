//
//  RedditViewModel.swift
//  BunnyWatch
//
//  Created by Mar Cabrera on 25/12/2023.
//

import Foundation

let endpoint = "https://www.reddit.com/r/rabbits.json"

class RedditViewModel: ObservableObject {
    @Published var redditData: RedditModel?
    
    let dataFetcher = RedditDataFetcher()
    
    func fetchRedditData() async throws -> RedditModel {
        redditData = try await dataFetcher.fetch(from: endpoint)
        return redditData!
    }
}

