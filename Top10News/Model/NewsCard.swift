//
//  NewsCardd.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/29/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

struct NewsCard {
    let featuredImage: UIImage!
    let coverColor: UIColor
    let title: String
    
    init(title: String, featuredImage: UIImage, coverColor: UIColor) {
        self.title = title
        self.featuredImage = featuredImage
        self.coverColor = coverColor
    }
    
    static func fetchNewsCards() -> [NewsCard] {
        return [
            NewsCard(title: "Biden", featuredImage: UIImage(named: "Biden")!, coverColor: #colorLiteral(red: 0, green: 0.08235294118, blue: 0.737254902, alpha: 0.3)),
            NewsCard(title: "Trump", featuredImage: #imageLiteral(resourceName: "Trump"), coverColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.3)),
            NewsCard(title: "Covid", featuredImage: #imageLiteral(resourceName: "Covid"), coverColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)),
            NewsCard(title: "Economy", featuredImage: #imageLiteral(resourceName: "Economy"), coverColor: #colorLiteral(red: 1, green: 0.1607843137, blue: 0.4078431373, alpha: 0.3)),
            NewsCard(title: "Sports", featuredImage: #imageLiteral(resourceName: "Sports"), coverColor: #colorLiteral(red: 0.8, green: 0.4509803922, blue: 0.8823529412, alpha: 0.3)),
            NewsCard(title: "Multimedia", featuredImage: #imageLiteral(resourceName: "Multimedia"), coverColor: #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 0.3))
        ]
    }
}
