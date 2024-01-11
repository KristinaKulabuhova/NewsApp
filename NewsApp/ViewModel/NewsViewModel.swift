//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Kristina on 10.12.2023.
//

import Foundation

final class NewsViewModel: ObservableObject {
    @Published var state = StateLoading.idle
    @Published private(set) var articles: [Article] = []
    private let service: ArticlesAPIService

    init(service: ArticlesAPIService) {
        self.service = service
    }

    @MainActor
    func getArticles() async {
        do {
            let params = RequestParameters(query: "bitcoin", pageSize: 20, page: 1)
            let articlesDTO = try await service.fetchArticles(with: params)
            let articlesModels = articlesDTO.map { $0.convertToModel() }
            articles = articlesModels
            state = .loaded
        } catch let error {
            self.state = .failed(error.localizedDescription)
        }
    }

    // MARK: - Subtypes

    enum StateLoading {
        case idle
        case failed(String)
        case loaded
    }
}
