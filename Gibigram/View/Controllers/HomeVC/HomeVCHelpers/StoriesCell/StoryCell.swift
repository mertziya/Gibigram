//
//  StoryCell.swift
//  Gibigram
//
//  Created by Mert Ziya on 20.12.2024.
//

import UIKit

struct storyState{
    static let opened = UIImage.storyBoundOpened
    static let notOpened = UIImage.storyBounds
}

class StoryCell: UICollectionViewCell {
    
    static let reuseIdentifier = "StoryCell"

    @IBOutlet weak var storyBounds: UIImageView! // identifying either the story is opened or not
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var storyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        storyBounds.clipsToBounds = true
        storyImage.clipsToBounds = true
        storyImage.layer.cornerRadius = storyImage.frame.width / 2
        
        
        
    }

}
