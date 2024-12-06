//
//  FeedCell.swift
//  IOSX-OldInstagramClone
//
//  Created by Mert Ziya on 6.12.2024.
//

import Foundation
import UIKit

class FeedCell : UICollectionViewCell{
    
    // MARK: - Properties:
    
    private let profilePicture : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "yilmaz")
        return iv
    }()
    
    private lazy var usernameButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yilmaz_Nazilli", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(usernameClicked), for: .touchUpInside)
        return button
    }()
    
    private let postImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "drinking-tea")
        return iv
    }()
    
    private lazy var likeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage( UIImage(systemName: "heart") , for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private lazy var commentButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage( UIImage(systemName: "bubble.right") , for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var shareButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage( UIImage(systemName: "paperplane") , for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var saveButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage( #imageLiteral(resourceName: "saveButton") , for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let likeLabel : UILabel = {
        let label = UILabel()
        label.text = "35 likes"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Yilmaz:"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Ersoyum bana 2 çay kapıp geldi!"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let uploadTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .black
        return label
    }()
   
    
    
    
    // MARK: - Lifecycles:
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        addSubview(profilePicture)
        profilePicture.anchor(top: topAnchor , left: leftAnchor , paddingTop: 8 , paddingLeft: 8)
        profilePicture.setDimensions(height: 40, width: 40)
        profilePicture.layer.cornerRadius = 20
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profilePicture, leftAnchor: profilePicture.rightAnchor, paddingLeft: 7)
        usernameButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .black)
        
        
        
        addSubview(postImage)
        postImage.anchor(top: profilePicture.bottomAnchor, left: leftAnchor , paddingTop: 5)
        postImage.setDimensions(height: frame.height * 0.7, width: frame.width)
        
        
        
        addSubview(likeButton)
        likeButton.anchor(top: postImage.bottomAnchor , left: leftAnchor , paddingTop: 4 , paddingLeft: 4)
        likeButton.setDimensions(height: 30, width: 30)
        
        addSubview(commentButton)
        commentButton.centerY(inView: likeButton , leftAnchor: likeButton.rightAnchor , paddingLeft: 5)
        commentButton.setDimensions(height: 30, width: 30)
        
        addSubview(shareButton)
        shareButton.centerY(inView: commentButton, leftAnchor: commentButton.rightAnchor , paddingLeft: 5)
        shareButton.setDimensions(height: 30, width: 30)
        
        addSubview(saveButton)
        saveButton.anchor(top: postImage.bottomAnchor, right: rightAnchor , paddingTop: 4 , paddingRight: 4)
        saveButton.setDimensions(height: 30, width: 30)
        
        
        
        addSubview(likeLabel)
        likeLabel.anchor(top: likeButton.bottomAnchor , left: leftAnchor, paddingLeft: 4)
        
        
        
        addSubview(usernameLabel)
        usernameLabel.anchor(top: likeLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 4)
        
        addSubview(descriptionLabel)
        descriptionLabel.centerY(inView: usernameLabel, leftAnchor: usernameLabel.rightAnchor, paddingLeft: 4)
        
        
        
        addSubview(uploadTimeLabel)
        uploadTimeLabel.anchor(top: descriptionLabel.bottomAnchor , left: leftAnchor , paddingTop: 4, paddingLeft: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}










// MARK: - Actions:
extension FeedCell{
    @objc func usernameClicked(){
        print("USERNAME CLICKED")
    }
    
    @objc func likeButtonPressed(){
        print("likeButton pressed")
    }
}
