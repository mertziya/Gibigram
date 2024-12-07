//
//  CustomButtons.swift
//  IOSX-Gibigram
//
//  Created by Mert Ziya on 6.12.2024.
//

import UIKit


class CustomButtons{
    
    static func loginButton() -> UIButton{
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.setHeight(70)
        return button
    }
    
    
    static func clickableText(title: String, fontSize: CGFloat, fontWeight : UIFont.Weight) -> UIButton{
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = .white
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        button.setTitle(title, for: .normal)
        return button
    }
    
}
