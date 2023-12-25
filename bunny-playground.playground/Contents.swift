import UIKit

var greeting = "Hello, playground"

let endpoint = "https://www.reddit.com/r/rabbits.json"

/*
private func fetch<T: Decodable>(from endpoint: String) async throws -> T {
    
    return ""
}

*/

struct RedditData: Codable {
    let data: ChildrenPosts
}

struct ChildrenPosts: Codable {
    let children: [ChildPost]
}

struct ChildPost: Codable {
    let data: Data
}

struct Data: Codable {
    let authorFullName: String
    let title: String
    
    
    enum CodingKeys: String, CodingKey {
        case authorFullName = "author_fullname"
        case title = "title"
    }
}

struct RedditFetcher {
    enum RedditFetcherError: Error {
        case invalidURL
    }
    
    func fetch(from endpoint: String) async throws -> [ChildPost] {
        guard let url = URL(string: endpoint) else {
            throw RedditFetcherError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let result = try JSONDecoder().decode(RedditData.self, from: data)
        
        return result.data.children
    }
}
Task {
    do {
        let redditFetcher = try await RedditFetcher().fetch(from: endpoint)
        
        for childPost in redditFetcher {
            print(childPost.data.title)
        }
    } catch let error {
        print(error)
        print("Error: \(error.localizedDescription)")
    }
}
