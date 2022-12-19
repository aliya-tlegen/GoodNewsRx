//
//  Article.swift
//  GoodNews
//
//  Created by Алия on 19.12.2022.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation

import Foundation

// MARK: - ArticleList -
struct ArticleList: Decodable {
    let articles: [Article]
}

extension ArticleList {
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e228b07f881a43358896e3b3f0796cb7")!
        return Resource(url: url)
    }()
}

// MARK: - Article -
struct Article: Decodable {
    let title: String
    let description: String?
}
