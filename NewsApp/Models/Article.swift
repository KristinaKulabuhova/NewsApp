//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Kristina on 28.12.2023.
//

import Foundation

struct Article: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String?
    let author: String?
    let imageURL: URL?
    let dateString: String?
    let source: Source

    init(title: String,
         description: String?,
         author: String?,
         urlToImage: String?,
         dateString: String?,
         source: Source) {
        self.title = title
        self.description = description
        self.author = author
        if let urlToImage {
            self.imageURL = URL(string: urlToImage)
        } else {
            self.imageURL = nil
        }
        if let dateString {
            // оптимизировать (вынести)
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
