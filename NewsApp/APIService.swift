//
//  APIService.swift
//  NewsApp
//
//  Created by Kristina on 10.12.2023.
//
import Foundation

enum APIError: Error {
    case invalidURL(url: String)
    case serverError(statusCode: Int)
    case requestError//(Error)
    case decodingError//(Error)
    case unknownError(Error)
}

class APIService {
    private let endpoint = "https://newsapi.org/v2/everything?q=apple&from=2023-12-09&to=2023-12-09&sortBy=popularity&apiKey=03198e1e8a2f4f03bae94d1709b61c16"

    func fetchData() async throws -> [ArticleDTO] {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL(url: endpoint)
        }

        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIError.requestError
        }

        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            throw APIError.serverError(statusCode: response.statusCode)
        }

        guard let data = try? JSONDecoder().decode(NewsResponseDTO.self, from: data) else {
            throw APIError.decodingError
        }
        
        return data.articles
    }
}
