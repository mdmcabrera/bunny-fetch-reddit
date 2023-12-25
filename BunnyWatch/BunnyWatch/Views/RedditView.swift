//
//  RedditView.swift
//  BunnyWatch
//
//  Created by Mar Cabrera on 25/12/2023.
//

import SwiftUI

struct RedditView: View {
    @ObservedObject var viewModel = RedditViewModel()
    @State private var isLoading = true
    

    var body: some View {
        ScrollView {
            VStack {
                if let redditData = viewModel.redditData?.data {
                    ForEach(redditData.children.indices, id: \.self) { index in
                        Text(redditData.children[index].data.title)
                    }
                     
                } else {
                    Text("Loading...")
                }
            }
            .onAppear {
                fetchData()
            }
            .disabled(isLoading)
        }
    }

    private func fetchData() {
        Task {
            do {
                try await viewModel.fetchRedditData()
                isLoading = false
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


#Preview {
    RedditView()
}
