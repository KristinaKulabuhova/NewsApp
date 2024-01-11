//
//  File.swift
//  NewsApp
//
//  Created by Kristina on 28.12.2023.
//

import SwiftUI

struct NewsItemView: View {
    let article: Article

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: article.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                Color.gray
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(width: 100, height: 100, alignment: .center)
            VStack(alignment: .leading) {
                Text(article.source.category.description)
                    .font(.caption2)
                    .foregroundStyle(Color.blue)
                    .padding(EdgeInsets(top: 4, leading: 14, bottom: 4, trailing: 14))
                    .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 25.0))
                Spacer(minLength: 0)
                Text(article.title)
                    .frame(maxWidth: .infinity)
                    .bold()
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
                AuthorView(authorName: article.author ?? "",
                           date: article.dateString ?? "")
            }
            .padding(.leading, 4)
            .frame(height: 100)
        }
        .frame(maxWidth: .infinity)
    }
}

struct AuthorView: View {
    let authorName: String
    let date: String

    var body: some View {
        HStack(spacing: 4) {
            Image("image")
                .resizable()
                .frame(width: 20, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(authorName)
                .font(.caption2)
            Text("•")
            Text(date)
                .font(.caption2)
        }
    }
}
