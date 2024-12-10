//
//  ProfileController.swift
//  IOSX-OldInstagramClone
//
//  Created by Mert Ziya on 5.12.2024.
//

import UIKit

class ProfileController: UICollectionViewController {
    
// MARK: - Properties:
    
    private var profileCollectionView : UICollectionView!
    
    
// MARK: - Lifecycles:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    
// MARK: - Helpers
    func configureCollectionView(){
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "profileCell")
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "profileHeader")
        
    }

}





// MARK: - CollectionViewDelegate and CollectionViewDataSource:
extension ProfileController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as? ProfileCell else{
            print("couldn't return ProfileCell")
            return UICollectionViewCell()
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "profileHeader", for: indexPath)
        
        return header
    }
}





extension ProfileController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width * 0.67 )
    }
    
}



