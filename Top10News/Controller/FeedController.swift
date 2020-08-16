//
//  HomeController.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/25/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import SDWebImage
import SideMenu

private let resuseIdentifier = "NewsCardCell"

class FeedController: UIViewController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            configureUserProfileImage()
        }
    }
    
    var newsCards = NewsCardViewModel().data
    
    var menu: SideMenuNavigationController?
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Saturday, July 25"
        label.font = UIFont(name: ralewayRegular, size: 26)
        label.tintColor = UIColor(named: grayText)
        
        return label
    }()
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Today"
        label.font = UIFont(name: loraBold, size: 30)
        label.tintColor = UIColor(named: blackText)
        
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 50, height: 50)
        iv.layer.cornerRadius = 50 / 2
        iv.layer.backgroundColor = UIColor.systemPink.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))

        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true

        return iv
    }()
    
    let newsCardCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .infinite, collectionViewLayout: UICollectionViewFlowLayout())
        
        return cv
    }()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isUserInteractionEnabled = true
        
        newsCardCollectionView.dataSource = self
        newsCardCollectionView.delegate = self
        newsCardCollectionView.register(NewsCardCell.self, forCellWithReuseIdentifier: resuseIdentifier)
        newsCardCollectionView.isUserInteractionEnabled = true
        
        configureUI()
        
        newsCardCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        menu = SideMenuNavigationController(rootViewController: ProfileMenuController())
        menu?.leftSide = false
        menu?.setNavigationBarHidden(true, animated: true)
        menu?.alwaysAnimate = true
        menu?.animationOptions = .allowUserInteraction
        menu?.animationOptions = .curveEaseInOut
        menu?.presentationStyle = .menuSlideIn
        menu?.presentingViewControllerUserInteractionEnabled = false
        menu?.blurEffectStyle = .systemUltraThinMaterialDark
        present(menu!, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemGray6
        

        let labelStack = UIStackView(arrangedSubviews: [dateLabel, todayLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 4
        
        dateLabel.text = currentDayAndDate()
        
        let stack = UIStackView(arrangedSubviews: [labelStack, profileImage])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        view.addSubview(stack)
        stack.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 5,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        let cellSize = CGSize(width: self.view.frame.width / 2 - 10, height: 300)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)

        newsCardCollectionView.setCollectionViewLayout(layout, animated: true)
        
        view.addSubview(newsCardCollectionView)
        newsCardCollectionView.backgroundColor = .systemGray6
        newsCardCollectionView.anchor(
            top: stack.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 5,
            paddingLeft: 3,
            paddingRight: 3,
            width: view.frame.width,
            height: view.frame.height - 150
        )
        
        newsCardCollectionView.isUserInteractionEnabled = true
        
    }
    
    func configureUserProfileImage() {
        guard let user = user else { return }

        guard let profileImageURL = URL(string: user.profileImage) else { return }
        profileImage.sd_setImage(with: profileImageURL, completed: nil)
    }
    
    func currentDayAndDate() -> String {
        var currentDayAndDate = ""
        let dateFormatter = DateFormatter()
        let date = Date()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
        
        currentDayAndDate = dateFormatter.string(from: date)
        
        return currentDayAndDate
    }

}

//MARK: - UICollectionViewDataSource

extension FeedController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifier, for: indexPath) as! NewsCardCell
        
        let newsCard = newsCards[indexPath.item]
        
        cell.newsCard = newsCard
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = NewsCardFeedConroller(newsCard: newsCards[indexPath.item])
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true, completion: nil)
    }
}
