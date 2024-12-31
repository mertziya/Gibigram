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
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func saveButton(_ sender: UIButton) {
        print("saved")
    }
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
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
