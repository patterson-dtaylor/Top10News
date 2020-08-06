//
//  NewsCardd.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/29/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

enum NewsCardType: Int {
    case biden
    case trump
    case health
    case business
    case sports
    case multimedia
    case science
    case technology
}

struct NewsCard {
    let title: String
    let featuredImage: UIImage!
    let type: NewsCardType!
}
