//
//  NewsCardViewModel.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/2/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation

struct NewsCardViewModel {
    
    let data = [
        NewsCard(title: "Biden", featuredImage: #imageLiteral(resourceName: "Biden"), type: NewsCardType(rawValue: 0)),
        NewsCard(title: "Trump", featuredImage: #imageLiteral(resourceName: "Trump"), type: NewsCardType(rawValue: 1)),
        NewsCard(title: "Health", featuredImage: #imageLiteral(resourceName: "Covid"), type: NewsCardType(rawValue: 2)),
        NewsCard(title: "Business", featuredImage: #imageLiteral(resourceName: "Economy"), type: NewsCardType(rawValue: 3)),
        NewsCard(title: "Sports", featuredImage: #imageLiteral(resourceName: "Sports"), type: NewsCardType(rawValue: 4)),
        NewsCard(title: "Multimedia", featuredImage: #imageLiteral(resourceName: "Multimedia"), type: NewsCardType(rawValue: 5)),
        NewsCard(title: "Science", featuredImage: #imageLiteral(resourceName: "Science"), type: NewsCardType(rawValue: 6)),
        NewsCard(title: "Technology", featuredImage: #imageLiteral(resourceName: "Technology"), type: NewsCardType(rawValue: 7))
        ]
}
