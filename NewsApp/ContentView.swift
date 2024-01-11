//
//  ContentView.swift
//  NewsApp
//
//  Created by Kristina on 10.12.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: NewsViewModel

    var body: some View {
        TabView {
            HomeView(viewModel: viewModel)
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
                }
        }
    }

    init(service: ArticlesAPIService) {
        _viewModel = StateObject(wrappedValue: NewsViewModel(service: service))
    }
}

#Preview {
    ContentView(service: ArticlesAPIServiceImpl())
}
