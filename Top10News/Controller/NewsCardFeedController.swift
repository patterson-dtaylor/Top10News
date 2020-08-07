//
//  NewsCardFeedController.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/1/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "News10TableViewCell"

class NewsCardFeedConroller: UITableViewController {
    
    //MARK: - Properties
    
    private var newsCard: NewsCard
    
    var articles = [Article]()
    
    //MARK: - Lifecycle
    
    init(newsCard: NewsCard) {

        self.newsCard = newsCard
        super.init(style: .plain)
        
        if let url = URL(string: getURL()) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
//        longPressGesture.minimumPressDuration = 1.0
//        longPressGesture.delegate = self
//        self.tableView.addGestureRecognizer(longPressGesture)
        
        let interaction = UIContextMenuInteraction(delegate: self)
        view.addInteraction(interaction)
        
        configure()
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
//    @objc func handleLongPress(longPressGesure: UILongPressGestureRecognizer) {
//        let longPress = longPressGesure.location(in: self.tableView)
//        let indexPath = self.tableView.indexPathForRow(at: longPress)
//        let article = articles[indexPath!.row]
//        let articleVM = ArticleViewModel(article)
//
//        if indexPath == nil {
//            print("DEBUG: Long press on table view, not row.")
//        } else if longPressGesure.state == UIGestureRecognizer.State.began {
//            print("DEBUG: Long press on row, at \(indexPath!.row)")
//            print("DEBUG: \(articleVM.title)")
//            print("DEBUG: \(articleVM.description)")
//            print("DEBUG: \(articleVM.urlToImage)")
//            print("DEBUG: \(articleVM.urlToArticle)")
//        }
//    }
    
    //MARK: - Helpers
    
    func configure() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = newsCard.title
        
        tableView.register(News10TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 300
        
//        WebService().preformRequest(with: url)
//        WebService().getArticles(url: url) { articles in
//            if let articles = articles {
//                self.articleListVM = ArticleListViewModel(articles: articles)
//
//                print(self.articleListVM.articles.count)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
//            }
//        }
        
    }
    
    func getURL() -> String {
        
        let viewModel = NewsCardFeedViewModel(newsCard: newsCard)
        let query = viewModel.urlForApi
        
        let url = "\(api)\(query)\(apiKey)"
        
        return url
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonArticles = try? decoder.decode(ArticleList.self, from: json) {
            articles = jsonArticles.articles
            tableView.reloadData()
        }
    }
    
}

extension NewsCardFeedConroller: UIGestureRecognizerDelegate {
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
//        print(article)
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
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { action in
            let article = self.articles[indexPath.row]
            let articleVM = ArticleViewModel(article)
            print("Debug: Share this article!!!")
            let item = [URL(string: articleVM.urlToArticle)]
            
            let ac = UIActivityViewController(activityItems: item as [Any], applicationActivities: nil)
            self.present(ac, animated: true)
        }
        
        let bookmark = UIAction(title: "Bookmark", image: UIImage(systemName: "bookmark.fill")) { action in
            print("DEBUG: Bookmark this article!!!")
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "Actions", children: [share, bookmark])
        }
    }
}

extension NewsCardFeedConroller: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
}
