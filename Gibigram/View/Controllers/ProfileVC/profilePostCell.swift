//
//  profilePostCell.swift
//  Gibigram
//
//  Created by Mert Ziya on 22.12.2024.
//

import Foundation
import UIKit

class profilePostCell : UICollectionViewCell {
    
    static let reuseIdentifier = "profilePostCell"
        
    let postImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        self.addSubview(postImage)
        postImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            postImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 1),
            postImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 1),
            postImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1)
        ])
        
        
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
