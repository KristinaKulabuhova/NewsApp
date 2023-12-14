//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Kristina on 10.12.2023.
//

import Foundation

@MainActor
final class NewsViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    @Published var articles: [ArticleModel] = []
    private let service = APIService()

    enum State {
        case idle
        case failed
        case loaded
    }

    func getArticles() async {
        do {
//TODO: На каком потоке будет выполнено service.fetchData(). На фоновом 
            let articlesDTO = try await service.fetchData()
            let articlesModels = articlesDTO.map { $0.mapDTOToModel() }
            self.articles = articlesModels
            self.state = .loaded
        } catch let error {
            print(error)
            self.state = .failed
        }
    }
}
