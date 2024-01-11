//
//  HomeView.swift
//  NewsApp
//
//  Created by Kristina on 28.12.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: NewsViewModel
    @State var isReadyShowAlert = true

    var body: some View {
        switch viewModel.state {
        case .idle:
            ProgressView()
                .task {
                    await viewModel.getArticles()
                    isReadyShowAlert = true
                }
        case .loaded:
            NavigationStack {
                NewsListView(viewModel: viewModel)
            }
        case .failed(let error):
            Color.red
                .alert(isPresented: $isReadyShowAlert) {
                    Alert(title: Text("Error: \(error)"),
                          primaryButton: .cancel(Text("Close")),
                          secondaryButton: .default(Text("Try again"),
                          action: {
                        viewModel.state = .idle
                        isReadyShowAlert = false
                        })
                    )
                }
        }
    }
}
