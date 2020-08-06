//
//  NewsCardFeedViewModel.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/2/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation

struct NewsCardFeedViewModel {
    
    private let newsCard: NewsCard
    private let type: NewsCardType
    
    var urlForApi: String {
        switch type {
        case .biden: return "q=biden"
        case .trump: return "q=trump"
        case .health: return "country=us&category=health"
        case .business: return "country=us&category=business"
        case .sports: return "country=us&category=sports"
        case .multimedia: return "country=us&category=entertainment"
        case .science: return "country=us&category=science"
        case .technology: return "country=us&category=technology"
        }
    }
    
    init(newsCard: NewsCard) {
        self.newsCard = newsCard
        self.type = newsCard.type
    }
}
