//
//  ProfileVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 19.12.2024.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {
    private let profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureProfileCollection()
    }
    
    private func configureProfileCollection(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(profilePostCell.self, forCellWithReuseIdentifier: profilePostCell.reuseIdentifier)
        
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
extension ProfileVC {
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
}




// MARK: - Collection View Cell Configurations:
extension ProfileVC : UICollectionViewDelegate, UICollectionViewDataSource {
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
    
    
}
