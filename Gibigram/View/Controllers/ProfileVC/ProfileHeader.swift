//
//  ProfileHeader.swift
//  Gibigram
//
//  Created by Mert Ziya on 23.12.2024.
//

import Kingfisher
import RxCocoa
import Combine
import UIKit



class ProfileHeader: UICollectionReusableView {
    static let theReuseIdentifier = "headerViewIdentifier"
    var viewModel = ProfileHeaderVM()
    private var cancellables = Set<AnyCancellable>()

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var postNumberLabel: UILabel!
    @IBOutlet weak var followerNumberLabel: UILabel!
    @IBOutlet weak var followingsNumberLabel: UILabel!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileSummaryLabel: UILabel!
    
    @IBOutlet weak var editProfileButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureHeadingUI()
        bindViewModel()
    }

    // Initialized the layers of the editProfileButton
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        editProfileButton.layer.cornerRadius = 8
        editProfileButton.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        editProfileButton.layer.borderWidth = 1
    }
  
    private func configureHeadingUI(){
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.cornerRadius = profileImage.frame.width / 2
        self.profileImage.contentMode = .scaleAspectFill
        
    }
    
    private func bindViewModel() {
        viewModel.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.updateUI(with: user)
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.updateLoadingIndicator(isLoading: isLoading)
            }
            .store(in: &cancellables)
    }

    private func updateUI(with user: User?) {
        if let user = user {
            self.profileImage.kf.setImage(with: URL(string: user.profileImageURL!))
            
            self.postNumberLabel.text = String(describing: user.posts!.count)
            self.followerNumberLabel.text = String(describing: user.followers!.count)
            self.followingsNumberLabel.text = String(describing: user.followings!.count)
            
            self.profileNameLabel.text = user.username
            self.profileSummaryLabel.text = user.summary
                        
        } else {
            print("User = nil")
        }
    }
    
    private func updateLoadingIndicator(isLoading : Bool) {
        if isLoading{
            self.profileImage.image = UIImage()
            self.indicatorView.startAnimating()
            
            self.postNumberLabel.text = ""
            self.followerNumberLabel.text = ""
            self.followingsNumberLabel.text = ""
            
            self.profileNameLabel.text = ""
            self.profileSummaryLabel.text = ""
            
        }else{
            self.indicatorView.stopAnimating()
        }
    }
    
}
