//
//  Utilites.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/26/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit

class Utilities {
    func showGradient(withColor1 color1: CGColor, withColor2 color2: CGColor, withButton button: UIButton) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = [color1, color2]

        button.layer.insertSublayer(gradientLayer, at: 0)
        
        
    }
    
    func inputContainerView (withColor color: UIColor, withImage image: String, textField: UITextField) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let iv = UIImageView()
        iv.image = UIImage(systemName: image)
        iv.tintColor = color
        view.addSubview(iv)
        iv.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            paddingLeft: 40,
            paddingBottom: 2
        )
        iv.setDimensions(width: 26, height: 26)
        
        view.addSubview(textField)
        textField.anchor(
            left: iv.rightAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 5,
            paddingBottom: 2
        )
        
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor(named: blackText)
        view.addSubview(dividerView)
        dividerView.anchor(
            left: iv.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 5,
            paddingRight: 40,
            height: 0.75
        )
        
        return view
    }
    
    func inputTextField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = UIColor(named: blackText)
        tf.font = UIFont.systemFont(ofSize: 19)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: grayText)!])
        tf.autocorrectionType = .no
        return tf
    }
    
    func pressedButtons(
        withTitle title: String,
        withTitleColor titleColor: UIColor,
        withFontSize fontSize: CGFloat,
        withCornerRadius cornerRadius: CGFloat) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.layer.cornerRadius = cornerRadius
        return button
        
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor(named: blackText)!.cgColor
        ])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor(named: blackText)!.cgColor
        ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        return button
    }

}
