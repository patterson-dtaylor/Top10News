//
//  NewsAPIService.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/2/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

struct WebService {
    
    static let shared = WebService()
    
    func getURL(newsCard: NewsCard) -> String {
        
        let viewModel = NewsCardFeedViewModel(newsCard: newsCard)
        let query = viewModel.urlForApi
        
        let url = "\(api)\(query)\(apiKey)"
        
        return url
    }
    
    func parse(json: Data, completion:  @escaping([Article]?) -> ()) {
        let decoder = JSONDecoder()
        
        let jsonArticles = try? decoder.decode(ArticleList.self, from: json)
        
        if let articleList = jsonArticles {
            completion(articleList.articles)
        }
    }
    
    func showError() -> UIAlertController {
            let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default))
            
            return ac
    }

}
