//
//  ExploreFeedController.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/9/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "News10TableViewCell"

class ExploreFeedController: UITableViewController {
    
    //MARK: - Properties
    
    private var queryText: String?
    private var queryURL: String?
    
    var articles = [Article]()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: - Lifecycle
    
    init(queryText: String, queryURL: String) {
        
        self.queryText = queryText
        self.queryURL = queryURL
        super.init(style: .plain)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemPink
        activityIndicator.center(inView: view)
        
        loadArticleData()

        let interaction = UIContextMenuInteraction(delegate: self)
        view.addInteraction(interaction)
        
        configure()
    }
    
    //MARK: - API
    
    func loadArticleData() {
        activityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: self.queryURL ?? "") {
                if let data = try? Data(contentsOf: url) {
                    WebService.shared.parse(json: data) { (articleList) in
                        self.articles.removeAll()
                        self.articles = articleList ?? []
                        DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()
                            self.tableView.reloadData()
                        }
                    }
                    return
                }
            }
            self.showError()
        }
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        guard let navTitle = queryText else { return }
        
        navigationItem.title = navTitle.capitalized
        
        tableView.frame = self.view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(News10TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }
    
    func showError() {
        DispatchQueue.main.async {
            let ac = WebService.shared.showError()
            self.present(ac, animated: true)
        }
    }
}

extension ExploreFeedController: UIGestureRecognizerDelegate {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! News10TableViewCell
        
        let article = articles[indexPath.row]
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
        let article = self.articles[indexPath.row]
        let articleVM = ArticleViewModel(article)
        
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { action in
            let item = [URL(string: articleVM.urlToArticle)]
            
            let ac = UIActivityViewController(activityItems: item as [Any], applicationActivities: nil)
            self.present(ac, animated: true)
        }
        
        let bookmark = UIAction(title: "Bookmark", image: UIImage(systemName: "bookmark.fill")) { action in
            BookmarkService.shared.uploadBookmark(withTitle: articleVM.title, withDescription: articleVM.description, withArticleURL: articleVM.urlToArticle) { (error, reference) in
                if error != nil {
                    let ac = BookmarkService.shared.showError(withErrorType: "loading")
                    self.present(ac, animated: true, completion: nil)
                }
            }
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "Actions", children: [share, bookmark])
        }
    }
}

extension ExploreFeedController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
}
