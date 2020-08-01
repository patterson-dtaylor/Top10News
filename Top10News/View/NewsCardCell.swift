//
//  NewsCardCell.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/29/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class NewsCardCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var newsCard: NewsCard! {
        didSet { self.configureUI() }
    }
    
    let cardImage: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    let cardBackgroundColorView: UIColor = {
        let color = UIColor()
        
        return color
    }()
    
    let cardLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Card Title"
        label.textColor = .white
        label.font = UIFont(name: ralewayBold, size: 36)
        
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - Helper
    
    func configureUI() {
        if let newsCard = newsCard {
            let cardbackground = newsCard.coverColor
            
            contentView.addSubview(cardImage)
            cardImage.image = newsCard.featuredImage.withRenderingMode(.alwaysOriginal)
            cardImage.layer.masksToBounds = true
            cardImage.tintColor = cardbackground
            cardImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
            
            
            
            contentView.addSubview(cardLabel)
            cardLabel.text = newsCard.title
            cardLabel.centerX(inView: cardImage, topAnchor: cardImage.topAnchor, paddingTop: 125)
            
            
        } else {
            cardImage.image = nil
            cardLabel.text = nil
        }
        
        
        
        
        
        
    }
}
