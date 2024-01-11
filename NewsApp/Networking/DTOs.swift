//
//  DTOs.swift
//  NewsApp
//
//  Created by Kristina on 28.12.2023.
//

protocol DTOConvertable {
    associatedtype Model

    func convertToModel() -> Model
}

struct ArticleDTO: Decodable, DTOConvertable {
    let title: String
    let description: String?
    let author: String?
    let urlToImage: String?
    let publishedAt: String?
    let source: SourceDTO

    func convertToModel() -> Article {
        Article(title: self.title,
                description: self.description,
                author: self.author,
                urlToImage: self.urlToImage,
                dateString: self.publishedAt,
                source: self.source.convertToModel())
    }
}

struct NewsResponseDTO: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleDTO]
}

struct SourceDTO: Decodable, DTOConvertable {
    let id: String?
    let name: String?
    let description: String?
    let country: String?
    let category: String?
    let url: String?

    func convertToModel() -> Source {
        Source(id: self.id,
               name: self.name,
               description: self.description,
               country: self.country,
               category: self.category,
               urlString: self.url)
    }
}
