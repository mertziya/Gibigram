//
//  StoryVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 29.12.2024.
//

import Foundation
import UIKit

class StoryVC: UIViewController{
    
    var storyImage = UIImageView()
    var user: User?
    var story: Story?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
}


extension StoryVC{
    private func setupUI(){
        view.addSubview(storyImage)
        storyImage.contentMode = .scaleAspectFit
        storyImage.kf.setImage(with: URL(string: story?.storyImageURL ?? ""))
        
        storyImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            storyImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            storyImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            storyImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
        
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismisView))
        swipeDownGesture.direction = .down
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc private func dismisView(){
        dismiss(animated: true, completion: nil)
    }
    
}
