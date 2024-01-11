//
//  Model.swift
//  NewsApp
//
//  Created by Kristina on 10.12.2023.
//
import Foundation

struct Source: Identifiable, Hashable {
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
        
        self.category = Category(rawValue: category)

        self.url = if let urlString = urlString {
            URL(string: urlString)
        } else { nil }
    }
}
