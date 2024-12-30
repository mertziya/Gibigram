//
//  PostVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 28.12.2024.
//

import Foundation
import UIKit
import Kingfisher

class PostVC: UIViewController{
    // MARK: - UI Elements:
    var profileImage = UIImageView()
    var profileName = UILabel()
    var postLocation = UILabel()
    var elipsisButton = UIButton()
    
    var postImage = UIImageView()
    
    var likeButton = UIButton()
    var commentButton = UIButton()
    var sendButton = UIButton()
    var saveButton = UIButton()
    
    var likesLabel = UILabel()
    
    var profileNameLabel = UILabel()
    var postDescriptionLabel = UILabel()
    
    // MARK: - Properties:
    var post = Post()
    var user : User?
    
    
    // MARK: - Lifecycles:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(popVC))
    }
    @objc private func popVC(){
        navigationController?.popViewController(animated: true)
    }
    
    
}





extension PostVC{
    private func setupUI() {
        // MARK: - Add Subviews
        // Logically the first Layer Vertically
        view.addSubview(profileImage)
        view.addSubview(profileName)
        view.addSubview(postLocation)
        view.addSubview(elipsisButton)
        
        // Logically the second layer Vertically
        view.addSubview(postImage)
        
        // Logically the third Layer Vertically
        view.addSubview(likeButton)
        view.addSubview(commentButton)
        view.addSubview(sendButton)
        view.addSubview(saveButton)
        
        // Logically the fourth Layer Vertically
        view.addSubview(likesLabel)
        
        // Logically the fifth Layer Vertically
        view.addSubview(profileNameLabel)
        view.addSubview(postDescriptionLabel)
        
        // MARK: - UI Design:
        guard let userURL = user?.profileImageURL else{print("DEBUG: Profile url error") ; return}
        DispatchQueue.main.async {
            self.profileImage.kf.setImage(with: URL(string: userURL))
            self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
            self.profileImage.contentMode = .scaleAspectFill
            self.profileImage.clipsToBounds = true
            self.profileImage.layer.masksToBounds = true
        }
        
        
        profileName.textColor = .label
        profileName.text = self.user?.username
        profileName.font = .boldSystemFont(ofSize: 13)
        
        postLocation.textColor = .label
        postLocation.text = self.post.postLocation ?? ""
        postLocation.font = .systemFont(ofSize: 13, weight: .regular)
        
        
        elipsisButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        elipsisButton.tintColor = .label
        
        guard let postImageURL = self.post.postImageURL else{print("ERROR Image"); return}
        print(postImageURL)
        postImage.kf.setImage(with: URL(string: postImageURL))
        postImage.clipsToBounds = true
        postImage.contentMode = .scaleAspectFit
        
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .large)
        likeButton.tintColor = .label
        let heartImage = UIImage(systemName: "heart", withConfiguration: largeConfig)
        likeButton.setImage(heartImage, for: .normal)
        likeButton.imageView?.contentMode = .scaleAspectFit
        
        commentButton.tintColor = .label
        let commentImage = UIImage(systemName: "bubble.middle.bottom", withConfiguration: largeConfig)
        commentButton.setImage(commentImage, for: .normal)
        commentButton.imageView?.contentMode = .scaleAspectFit
        
        sendButton.tintColor = .label
        let sendImage = UIImage(systemName: "paperplane", withConfiguration: largeConfig)
        sendButton.setImage(sendImage, for: .normal)
        sendButton.imageView?.contentMode = .scaleAspectFit
        
        saveButton.tintColor = .label
        let saveImage = UIImage(systemName: "bookmark", withConfiguration: largeConfig)
        saveButton.setImage(saveImage, for: .normal)
        saveButton.imageView?.contentMode = .scaleAspectFit
        
        likesLabel.text = "\(String(describing: self.post.postLikes ?? 0)) Likes"
        likesLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        
        profileNameLabel.text = user?.username
        profileNameLabel.tintColor = .label
        profileNameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        
        postDescriptionLabel.text = self.post.postDescription ?? "Deffault"
        postDescriptionLabel.tintColor = .label
        postDescriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        
        
        
        
        // MARK: - Constraints:
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileName.translatesAutoresizingMaskIntoConstraints = false
        postLocation.translatesAutoresizingMaskIntoConstraints = false
        elipsisButton.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        postDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            profileImage.heightAnchor.constraint(equalToConstant: 32),
            profileImage.widthAnchor.constraint(equalToConstant: 32),
            
            profileName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 12),
            profileName.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: -4),
            
            postLocation.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 2),
            postLocation.leftAnchor.constraint(equalTo: profileName.leftAnchor, constant: 0),
            
            elipsisButton.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -16),
            elipsisButton.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 0),
            elipsisButton.heightAnchor.constraint(equalToConstant: 32),
            elipsisButton.widthAnchor.constraint(equalToConstant: 24),
            
            postImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            postImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            postImage.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            postImage.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            likeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            likeButton.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12),
            likeButton.heightAnchor.constraint(equalToConstant: 24),
            likeButton.widthAnchor.constraint(equalToConstant: 36),
            
            commentButton.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 12),
            commentButton.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12),
            commentButton.heightAnchor.constraint(equalToConstant: 24),
            commentButton.widthAnchor.constraint(equalToConstant: 36),
            
            sendButton.leftAnchor.constraint(equalTo: commentButton.rightAnchor, constant: 12),
            sendButton.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12),
            sendButton.heightAnchor.constraint(equalToConstant: 24),
            sendButton.widthAnchor.constraint(equalToConstant: 36),
            
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            saveButton.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 12),
            saveButton.heightAnchor.constraint(equalToConstant: 24),
            saveButton.widthAnchor.constraint(equalToConstant: 36),
            
            likesLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 12),
            likesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            profileNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            profileNameLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 8),
            
            postDescriptionLabel.leftAnchor.constraint(equalTo: profileNameLabel.rightAnchor, constant: 4),
            postDescriptionLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 8),
            
            
            
        ])
        
        
    }
}
