//
//  Top10Controller.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/25/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "News10TableViewCell"

class Top10Controller: UITableViewController {
    
    //MARK: - Properties
    
    var articles = [Article]()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "top10NavBar"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        tableView.register(News10TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 300
        
        if let url = URL(string: top10List) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonArticles = try? decoder.decode(ArticleList.self, from: json) {
            articles = jsonArticles.articles
            tableView.reloadData()
        }
    }

}

extension Top10Controller {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(articles.count)
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! News10TableViewCell
        
        let article = articles[indexPath.row]
        print(article)
        let articleVM = ArticleViewModel(article)
        cell.titleLabel.text = articleVM.title
        cell.descriptionLabel.text = articleVM.description
        if let imageURL = URL(string: articleVM.urlToImage) {
            guard let articleImageData = try? Data(contentsOf: imageURL) else { return UITableViewCell()}
            cell.articleImageView.image = UIImage(data: articleImageData)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let articleVM = ArticleViewModel(article)
        if let url = URL(string: articleVM.urlToArticle) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
