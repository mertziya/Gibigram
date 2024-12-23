//
//  ProfileVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 19.12.2024.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {
    
    // MARK: Properties:
    private let profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var pickedImage = UIImage()
    private let imageUploader = ImageUploader()
    
    
    // MARK: - Lifecycles:
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureProfileCollection()
    }
    
    private func configureProfileCollection(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(profilePostCell.self, forCellWithReuseIdentifier: profilePostCell.reuseIdentifier)
        profileCollectionView.register(UINib(nibName: "ProfileHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: ProfileHeader.theReuseIdentifier)
        
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
    
    
    
}




// MARK: - Collection View Cell Configurations:
extension ProfileVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        31
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = profileCollectionView.dequeueReusableCell(withReuseIdentifier: profilePostCell.reuseIdentifier, for: indexPath) as? profilePostCell
        else{
            return UICollectionViewCell()
        }
        cell.postImage.image = UIImage.yilmaz
        
        return cell
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
        didOpenImagePickerWhenClicked(theImageView: header.profileImage)
        
        return header
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.width * 0.67) // There is no stories section rn. Can be updated later.
    }
    
}
