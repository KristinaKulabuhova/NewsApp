//
//  ContentView.swift
//  NewsApp
//
//  Created by Kristina on 10.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: NewsViewModel())
                .tabItem {
                    Image(systemName: "house.fill")
                }
            Color.purple
                .tabItem {
                    Image(systemName: "bookmark.fill")
                }
            Color.yellow
                .tabItem {
                    Image(systemName: "bell.fill")
                }
            Color.green
                .tabItem {
                    Image(systemName: "person.fill")
                        .padding(.top, 10)
                }
        }
    }
}

struct HomeView: View {
    @ObservedObject var viewModel = NewsViewModel()

    var body: some View {
        switch viewModel.state {
        case .idle:
            ProgressView()
                .task {
                    await viewModel.getArticles()
                }
        case .loaded:
            NavigationStack {
                NewsListView(articles: $viewModel.articles)
            }
        case .failed:
            Color.red
        }
    }
}

#Preview {
    ContentView()
}

struct NewsListView: View {
    @Binding var articles: [ArticleModel]

    var body: some View {
        List {
            if let popularArticleURL = articles.first?.urlToImage {
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
                ForEach(articles.dropFirst().prefix(20)) { news in
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
        .navigationDestination(for: ArticleModel.self) { news in
            Text(news.title)
                .padding()
        }
    }
}

struct NewsItemView: View {
    private let article: ArticleModel

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: article.urlToImage) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .background(Color.red)
                    .frame(width: 100, height: 100, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                Color.gray
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(width: 100, height: 100, alignment: .center)
            VStack(alignment: .leading) {
                Text(article.source.category.rawValue)
                    .font(.caption2)
                    .foregroundStyle(Color.blue)
                    .padding(EdgeInsets(top: 4, leading: 14, bottom: 4, trailing: 14))
                    .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 25.0))
                Spacer(minLength: 0)
                Text(article.title)
                    .frame(maxWidth: .infinity)
                    .bold()
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
                AuthorView(autorImageString: "image",
                           authorName: article.author ?? "",
                           date: article.dateString ?? "")
            }
            .padding(.leading, 4)
            .frame(height: 100)
        }
        .frame(maxWidth: .infinity)
    }

    init(article: ArticleModel) {
        self.article = article
    }
}

struct AuthorView: View {
    private let autorImageString: String
    private let authorName: String
    private let date: String

    var body: some View {
        HStack(spacing: 4) {
            Image(autorImageString)
                .resizable()
                .frame(width: 20, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(authorName)
                .font(.caption2)
            Text("•")
            Text(date)
                .font(.caption2)
        }
    }

    init(autorImageString: String, authorName: String, date: String) {
        self.autorImageString = autorImageString
        self.authorName = authorName
        self.date = date
    }
}
