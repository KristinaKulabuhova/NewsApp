//
//  Category.swift
//  NewsApp
//
//  Created by Kristina on 28.12.2023.
//

enum Category: String {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology

    static var defaultValue = Category.general

    init(rawValue: String?) {
        if let value = rawValue {
            self = Category(rawValue: value)
        } else {
            self = Category.general
        }
    }

    var description: String {
        self.rawValue
    }
}
