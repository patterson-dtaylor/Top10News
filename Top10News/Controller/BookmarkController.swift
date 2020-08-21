//
//  BookmarkController.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/25/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BookmarkTableViewCell"

class BookmarkController: UITableViewController {
    
    //MARK: - Properties
    
    private var bookmarks = [Bookmark]() {
        didSet { tableView.reloadData() }
    }
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchBookmarks()

    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Bookmarks"
        
        view.backgroundColor = .systemGray6
        
        tableView.frame = self.view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        let interaction = UIContextMenuInteraction(delegate: self)
        view.addInteraction(interaction)
        
    }
    
    func fetchBookmarks() {
        tableView.refreshControl?.beginRefreshing()
        BookmarkService.shared.fetchBookmarks { bookmarks in
            self.bookmarks = bookmarks.sorted(by: { $0.timestamp > $1.timestamp })
            self.tableView.refreshControl?.endRefreshing()
        }
        tableView.reloadData()
    }

}

extension BookmarkController: UIGestureRecognizerDelegate {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! BookmarkTableViewCell
        
        let bookmark = bookmarks[indexPath.row]
        
        cell.titleLabel.text = bookmark.title
        cell.descriptionLabel.text = bookmark.description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookmark = bookmarks[indexPath.row]
        
        if let url = URL(string: bookmark.url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let bookmark = self.bookmarks[indexPath.row]
        
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { action in
            
            let item = [URL(string: bookmark.url)]
            
            let ac = UIActivityViewController(activityItems: item as [Any], applicationActivities: nil)
            self.present(ac, animated: true)
        }
        
        let deleteBookmark = UIAction(title: "Delete", image: UIImage(systemName: "delete.right.fill")) { action in
            BookmarkService.shared.delteBookmark(withBookmarkId: bookmark.bookmarkID) { (error, ref) in
                if error != nil {
                    let ac = BookmarkService.shared.showError(withErrorType: "deleting")
                    self.present(ac, animated: true, completion: nil)
                }
                self.bookmarks.remove(at: indexPath.row)
                self.fetchBookmarks()
            }
            
            
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "Actions", children: [share, deleteBookmark])
        }
    }
}



extension BookmarkController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
}
