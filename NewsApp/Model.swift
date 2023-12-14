//
//  Model.swift
//  NewsApp
//
//  Created by Kristina on 10.12.2023.
//
import Foundation

struct ArticleModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String?
    let author: String?
    let urlToImage: URL?
    let dateString: String?
    let source: SourceModel

    init(title: String,
         description: String?,
         author: String?,
         urlToImage: String?,
         dateString: String?,
         source: SourceModel) {
        self.title = title
        self.description = description
        self.author = author
        if let urlToImage {
            self.urlToImage = URL(string: urlToImage)
        } else {
            self.urlToImage = nil
        }
        if let dateString {
            let date = ISO8601DateFormatter().date(from: dateString)
            let datesFormatter = DateFormatter()
            datesFormatter.dateStyle = .medium
            self.dateString = datesFormatter.string(from: date!)
        } else {
            self.dateString = nil
        }
        self.source = source
    }
}

struct ArticleDTO: Codable {
    let title: String
    let description: String?
    let author: String?
    let urlToImage: String?
    let publishedAt: String?
    let source: SourceDTO

    func mapDTOToModel() -> ArticleModel {
        ArticleModel(title: self.title,
                     description: self.description,
                     author: self.author,
                     urlToImage: self.urlToImage,
                     dateString: self.publishedAt,
                     source: self.source.mapDTOToModel())
    }
}

struct SourcesResponse: Codable {
    let status: String
    let sources: [SourceDTO]
}

struct NewsResponseDTO: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleDTO]
}

struct SourceDTO: Codable {
    let id: String?
    let name: String?
    let description: String?
    let country: String?
    let category: String?
    let url: String?

    func mapDTOToModel() -> SourceModel {
        SourceModel(id: self.id,
                    name: self.name,
                    description: self.description,
                    country: self.country,
                    category: self.category,
                    urlString: self.url)
    }
}

struct SourceModel: Identifiable, Hashable {
    let id: String?
    let name: String?
    let description: String?
    let country: String?
    let category: Category
    let url: URL?

    init(id: String?, name: String?, description: String?, country: String?, category: String?, urlString: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.country = country
        
        //TODO: - подумать, можно ли сделать тут инициализацию лучше
        if let category = category {
            self.category = Category(rawValue: category) ?? .general
        } else {
            self.category = .general
        }

        if let urlString = urlString {
            self.url = URL(string: urlString)
        } else {
            self.url = nil
        }
    }
}

//TODO: - сделать категорию, вытаскивая возможно из ссылок или как-то определять ее
enum Category: String {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}
