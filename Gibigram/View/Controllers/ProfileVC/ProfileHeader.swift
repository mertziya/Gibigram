//
//  ProfileHeader.swift
//  Gibigram
//
//  Created by Mert Ziya on 23.12.2024.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa


class ProfileHeader: UICollectionReusableView {
    static let theReuseIdentifier = "headerViewIdentifier"
    private let viewModel = ProfileHeaderVM()
    private let disposeBag = DisposeBag()
    

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var postNumberLabel: UILabel!
    @IBOutlet weak var followerNumberLabel: UILabel!
    @IBOutlet weak var followingsNumberLabel: UILabel!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileSummaryLabel: UILabel!
    
    @IBOutlet weak var editProfileButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureHeadingUI()
        buttonClicked()
        
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
        viewModel.userObservable
            .observe(on: MainScheduler.instance) // Ensure UI updates happen on the main thread
            .subscribe(onNext: { [weak self] user in
                guard let self = self else { return }
                self.updateUI(with: user)
            })
            .disposed(by: disposeBag)
    }
    
    
    private func updateUI(with user: User) {
        profileNameLabel.text = user.username
        profileSummaryLabel.text = user.summary
        
        guard let stringURL = user.profileImageURL else{print("DEBUG : nil URL") ; return}
        if let imageUrl = URL(string: stringURL) {
            // Load the image (use an appropriate library or custom logic)
            profileImage.kf.setImage(with: imageUrl)
        }
        
        postNumberLabel.text = (String(describing: user.posts!.count))
        followerNumberLabel.text = (String(describing: user.followers!.count))
        followingsNumberLabel.text = (String(describing: user.followings!.count))
        
        
        
    }
}



// MARK: - Actions:
extension ProfileHeader {
    private func buttonClicked(){
        editProfileButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    @objc private func tappedButton(){
        print("DEBUG: Edit profile tapped")
    }
}
