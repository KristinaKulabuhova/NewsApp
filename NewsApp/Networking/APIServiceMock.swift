//
//  APIServiceMock.swift
//  NewsApp
//
//  Created by Kristina on 03.01.2024.
//

import Foundation

final class ArticlesAPIServiceMockImpl: ArticlesAPIService {
    func fetchArticles(with params: RequestParameters) async throws -> [ArticleDTO] {
        if let error {
            throw error
        } else {
            let data = try JSONDecoder().decode(NewsResponseDTO.self, from: data ?? Data())
            return data.articles
        }
    }

    var baseURL: String { "https://newsapi.org" }
    var path: String { "/v2/everything" }

    var data: Data?
    var error: Error?

    init(error: Error? = nil) {
        self.error = error
        self.data = DataFixtures.validNewsListData
    }
}
