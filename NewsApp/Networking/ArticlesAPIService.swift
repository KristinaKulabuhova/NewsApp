//
//  APIService.swift
//  NewsApp
//
//  Created by Kristina on 10.12.2023.
//
import Foundation

enum APIError: LocalizedError {
    case serverError(statusCode: Int)
}

protocol ArticlesAPIService {
    var baseURL: String { get }
    var path: String { get }

    func fetchArticles(with params: RequestParameters) async throws -> [ArticleDTO]
}

struct RequestParameters {
    var query: String = "apple"
    var sortBy: String?
    var pageSize: Int?
    var page: Int?

    var dictionaryRepresentation: [String: Any] {
        return [
            "q": query,
            "sortBy": sortBy as Any,
            "pageSize": pageSize as Any,
            "page": page as Any
        ]
    }
}

final class ArticlesAPIServiceImpl: ArticlesAPIService {
    var baseURL: String { "https://newsapi.org" }
    var path: String { "/v2/everything" }
    private var apikey: String { "03198e1e8a2f4f03bAPIae94d1709b61c16" }

    func fetchArticles(with params: RequestParameters) async throws -> [ArticleDTO] {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.path = path
        urlComponents.queryItems = []
        for (key, value) in params.dictionaryRepresentation {
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
        }
        urlComponents.queryItems?.append(URLQueryItem(name: "apikey", value: apikey))
        return try await makeReuqest(url: urlComponents.url!)
    }

    private func makeReuqest(url: URL) async throws -> [ArticleDTO] {
        let (data, response) = try await URLSession.shared.data(from: url)

        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw APIError.serverError(statusCode: response.statusCode)
        }

        let newsResponse = try JSONDecoder().decode(NewsResponseDTO.self, from: data)

        return newsResponse.articles
    }
}
