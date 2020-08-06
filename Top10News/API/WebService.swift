//
//  NewsAPIService.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/2/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import Foundation

protocol WebServiceDelegate {
    func didUpdateArticle(_ webService: WebService, article: Article)
    func didFailWithError(error: Error)
}

struct WebService {
    
    var delegate: WebServiceDelegate?
    
    func getArticles(url: URL, completion: @escaping([Article]?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                
                if let articleList = articleList {
                    print(articleList.articles)
                    completion(articleList.articles)
                }
            }
        }.resume()
    }
    
    func preformRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    print(safeData)
                    if let article = self.parseJSON(safeData) {
                        self.delegate?.didUpdateArticle(self, article: article)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ articleData: Data) -> Article? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(Article.self, from: articleData)
            let title = decodedData.title
            let description = decodedData.description
            let urlToArticle = decodedData.url
            let urlToImage = decodedData.urlToImage
            
            let article = Article(title: title, description: description, url: urlToArticle, urlToImage: urlToImage)
            print(article)
            return article
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
