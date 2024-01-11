//
//  NewsListLoaderTest.swift
//  NewsApp
//
//  Created by Kristina on 03.01.2024.
//

import Foundation
import XCTest

final class NewsListLoaderTest: XCTestCase {
    func testSuccessfullResponse() async {
        let fixtureData = DataFixtures.validNewsListData

        let networkService = ArticlesAPIServiceMockImpl()
        networkService.data = fixtureData
        networkService.error = nil

        let networkManager = ArticlesAPIServiceImpl()

        var expectedResults: [ArticleDTO]?

        do {
            expectedResults = try await networkManager.fetchArticles(with: RequestParameters())
            XCTAssertNotNil(expectedResults)
        } catch let expectedError {
            XCTAssertNil(expectedError)
        }
    }

    func testSuccessGetArticles() async {
        let networkService = ArticlesAPIServiceMockImpl()
        let viewModel = NewsViewModel(service: networkService)
        await viewModel.getArticles()
        XCTAssertFalse(viewModel.articles == [])
    }
}
