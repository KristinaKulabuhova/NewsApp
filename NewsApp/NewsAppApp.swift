//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Kristina on 10.12.2023.
//

import SwiftUI

@main
struct NewsApp: App {
    let service = ArticlesAPIServiceImpl()

    var body: some Scene {
        WindowGroup {
            ContentView(service: service)
        }
    }
}
