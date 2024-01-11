//
//  File.swift
//  NewsApp
//
//  Created by Kristina on 28.12.2023.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var viewModel: NewsViewModel

    var body: some View {
        List {
            if let popularArticleURL = viewModel.articles.first?.imageURL {
                Section {
                    Text("Popular Topics")
                        .bold()
                        .font(.title3)
                    AsyncImage(url: popularArticleURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                    } placeholder: {
                        Color.gray
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .listRowSeparator(.hidden)
            }

            Section {
                ForEach(viewModel.articles) { news in
                    NavigationLink(value: news) {
                        NewsItemView(article: news)
                            .listRowSeparator(.hidden)
                    }
                }
            } header: {
                Text("Recomended For You")
                    .bold()
                    .foregroundStyle(Color.black)
                    .font(.title3)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
        .toolbar {
            Image(systemName: "line.horizontal.3")
        }
        .navigationTitle("News")
        .navigationDestination(for: Article.self) { news in
            Text(news.title)
                .padding()
        }
    }
}
