//
//  DataFixtures.swift
//  NewsApp
//
//  Created by Kristina on 03.01.2024.
//

import Foundation

final class DataFixtures {
    static var validNewsListData: Data? { jsonData("news_fixture") }

    private static func jsonData(_ filename: String) -> Data? {
        guard let path = Bundle(for: self).path(forResource: filename, ofType: "json") else { return nil }
        let jsonString = try? String(contentsOfFile: path, encoding: .utf8)
        return jsonString?.data(using: .utf8)
    }
}
