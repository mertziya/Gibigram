//
//  ProfileVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 19.12.2024.
//

import UIKit
import FirebaseAuth
import Combine
import Kingfisher

class ProfileVC: UIViewController {
    
    // MARK: Properties:
    private let profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var isRefreshing = false
    
    private var pickedImage = UIImage()
    private let imageUploader = ImageUploader()
    private let profileHeaderVM = ProfileHeaderVM()
    private var cancellables = Set<AnyCancellable>()
    
    private let profileVM = ProfileVM()
    
    var theUser : User? // For binding user.fullname to navigation title.
    var canPrintMessage = true
    var profileHeader: ProfileHeader?
    
    var currentUserPosts = [Post]() // Holds the information about the current user's Post
    var currentUserStories = [Story]() // Holds the information about the current user's Story
    
    
    // MARK: - Lifecycles:
    override func viewDidLoad() {
        super.viewDidLoad()
        profileVM.delegate = self
        profileVM.fetchPostsOfCurrentUser()
        profileVM.fetchStoriesOfCurrentUser()
        
        configureNavigationBar()
        self.configureProfileCollection()
        bindNavTitle()
        profileCollectionView.showsVerticalScrollIndicator = false
    }
    

    private func configureProfileCollection(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(profilePostCell.self, forCellWithReuseIdentifier: profilePostCell.reuseIdentifier)
        
        
        profileCollectionView.register(StoriesCellForCollectionView.self, forCellWithReuseIdentifier: StoriesCellForCollectionView.identifier)
        profileCollectionView.register(UINib(nibName: "ProfileHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: ProfileHeader.theReuseIdentifier)
        
        profileCollectionView.alwaysBounceVertical = true // Independent from the items inside colelction view, Collection view is always scrollable !!!
        // --> VERY USEFUL
        
        layoutConfigForCollectionView()
        
        view.addSubview(profileCollectionView)
        profileCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileCollectionView.topAnchor.constraint(equalTo: view.topAnchor , constant: 0),
            profileCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            profileCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            profileCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func bindNavTitle(){
        profileHeaderVM.$user
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.navigationItem.title = user?.fullname
                self.theUser = user
            }
            .store(in: &cancellables)
    }
    
 
}



// MARK: - Actions:
extension ProfileVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private func configureNavigationBar(){
        let bar = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(logoutUser))
        bar.tintColor = UIColor.label
        navigationItem.rightBarButtonItem = bar
    }
    
    @objc func logoutUser(){
        do{
            try Auth.auth().signOut()
            let nav = UINavigationController(rootViewController: LoginVC())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
        }catch{
            print("couldn't sign the user out.")
        }
    }
    
    private func didOpenImagePickerWhenClicked(theImageView : UIImageView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openPicker))
        theImageView.addGestureRecognizer(gesture)
    }
    
    @objc private func openPicker(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = true
        
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.pickedImage = editedImage
        }else if let originalImage = info[.originalImage] as? UIImage {
            self.pickedImage = originalImage
        }
        
        
        imageUploader.uploadImage(image: pickedImage) { imageURL in
            print("debug")
            guard let url = imageURL else{print("DEBUG: bad URL") ; return}
            UserService.addProfileImageURL(url: url) { error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                }else{
                    print("DEBUG: SUCCESS !")
                }
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    private func didShowEditProfileWhenClicked(theButton : UIButton){
        theButton.addTarget(self, action: #selector(showEditProfileVC), for: .touchUpInside)
    }
    
    @objc private func showEditProfileVC(){
        let vc = EditProfileVC()
        self.present(vc, animated: true)
    }
}




// MARK: - Collection View Cell Configurations:
extension ProfileVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProfileViewModelDelegate{
    func didFetchPostsOfUser(_ posts: [Post]) {
        self.currentUserPosts = posts
        self.profileCollectionView.reloadData()
    }
    
    func didFetchStoriesOfUser(_ stories: [Story]) {
        print("fetch stories triggered")
        self.currentUserStories = stories
        self.profileCollectionView.reloadData()
    }
    
    func didFailWithError(_ error: any Error) {
        print("stories error triggered")
        self.currentUserStories = []
        self.currentUserPosts = []
        self.profileCollectionView.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentUserPosts.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != 0 {
            guard let cell = profileCollectionView.dequeueReusableCell(withReuseIdentifier: profilePostCell.reuseIdentifier, for: indexPath) as? profilePostCell
            else{
                return UICollectionViewCell()
            }
            let post = self.currentUserPosts[indexPath.row - 1]
            let url = URL(string: post.postImageURL ?? "")
            cell.postImage.kf.setImage(with: url)

            return cell
        }else{
            guard let storiesCell = profileCollectionView.dequeueReusableCell(withReuseIdentifier: StoriesCellForCollectionView.identifier, for: indexPath) as? StoriesCellForCollectionView else{
                return UICollectionViewCell()
            }
            
            storiesCell.collectionView.showsHorizontalScrollIndicator = false
            storiesCell.stories = self.currentUserStories
            
            return storiesCell
        }
    }
    
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            // Custom size for the first cell (e.g., StoriesCellForCollectionView)
            return CGSize(width: collectionView.frame.width, height: 100) // Adjust height as needed
        } else {
            // Default size for other cells (profilePostCell)
            let numberOfCellsPerRow: CGFloat = 3
            let cellWidth = collectionView.frame.width / numberOfCellsPerRow
            return CGSize(width: cellWidth, height: cellWidth) // Square cells
        }
    }
    
    
    private func layoutConfigForCollectionView(){
        let layout = UICollectionViewFlowLayout()
        // Set item size
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 , height: UIScreen.main.bounds.width / 3) // Adjust size as needed

        // Set spacing between items
        layout.minimumInteritemSpacing = 0 // Horizontal spacing
        layout.minimumLineSpacing = 0 // Vertical spacing
        layout.sectionInset = .zero
        
        // Set scroll direction
        layout.scrollDirection = .vertical // Use .horizontal for horizontal scrolling
        

        self.profileCollectionView.collectionViewLayout = layout
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = profileCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeader.theReuseIdentifier, for: indexPath) as? ProfileHeader else{
            return UICollectionReusableView()
        }
        profileHeader = header
        if let profileHeader = profileHeader{
            didOpenImagePickerWhenClicked(theImageView: profileHeader.profileImage)
            didShowEditProfileWhenClicked(theButton: header.editProfileButton)
        }
        return header
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.width * 0.67) // There is no stories section rn. Can be updated later.
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffSet = scrollView.contentOffset.y
        
        if yOffSet < -200 && canPrintMessage {
            print("Scrolled to the top and beyond")
            canPrintMessage = false
            
            profileHeader?.viewModel.updateUser() // Updates the viewmodel inside the data at the header
            profileHeaderVM.updateUser() // Updates the current ViewModel.
            self.profileCollectionView.reloadData() // Reloads the data of the collection view cells.
            self.profileVM.fetchPostsOfCurrentUser()
            self.profileVM.fetchStoriesOfCurrentUser()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.canPrintMessage = true
            }
        }
    }
}
