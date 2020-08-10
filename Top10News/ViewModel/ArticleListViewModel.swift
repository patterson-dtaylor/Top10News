//
//  ArticleListViewModel.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/3/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    private let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
    
    var title: String {
        return self.article.title ?? ""
    }

    var description: String {
        return self.article.description ?? ""
    }
    
    var urlToArticle: String {
        return self.article.url ?? ""
    }
    
    var urlToImage: String {
        return self.article.urlToImage ?? "https://www.webdesigndev.com/wp-content/uploads/2015/04/Free-404-Error-Page-PSD-Template.jpg"
    }
}
