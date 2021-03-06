//
//  NewsCardFeedCell.swift
//  Top10News
//
//  Created by Taylor Patterson on 8/3/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class News10TableViewCell: UITableViewCell {
    //MARK: - Properties
    
    private let articleImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 414, height: 200)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.backgroundColor = UIColor.systemPink.cgColor
        
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: loraBold, size: 18)
        label.text = "Test Article Title"
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: ralewayRegular, size: 14)
        label.text = "Lorem ipsum dolor sit amet, massa nam ac, leo quisque morbi vel. Consectetuer proin et duis, ut mauris augue placerat, feugiat sed cras sagittis mollis egestas, sagittis magna magna eu mi curabitur. Quis nulla penatibus mauris adipiscing condimentum, habitasse quis ligula neque, torquent sociosqu eros in potenti ornare posuere. Cursus sodales sociis pede eros purus suspendisse, sapien nunc dolor vulputate perspiciatis volutpat, sit faucibus nullam libero, erat vel id amet. Inceptos eget vitae cursus justo nonummy, viverra magna lorem sodales porta."
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [articleImageView, titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.distribution = .fill
        stack.contentMode = .scaleToFill
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingBottom: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - API
    
    //MARK: - Helpers
}
