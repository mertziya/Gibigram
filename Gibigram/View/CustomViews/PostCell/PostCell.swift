//
//  PostCell.swift
//  Gibigram
//
//  Created by Mert Ziya on 20.12.2024.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var postLocation: UILabel!
    @IBOutlet weak var ellipsisButton: UIButton!
    
    @IBOutlet weak var postImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.image = UIImage.yilmaz
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
