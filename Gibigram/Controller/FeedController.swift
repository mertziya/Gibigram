//
//  Untitled.swift
//  IOSX-OldInstagramClone
//
//  Created by Mert Ziya on 5.12.2024.
//

import Foundation
import UIKit
import FirebaseAuth


class FeedController: UIViewController{
    
    private var collectionView : UICollectionView! // our collection view for the feed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewFlowLayout()
        addLogoutButtonToNav()
        self.view.backgroundColor = .systemBackground
    }
    
}





// MARK: - Collection View's Layout configurations:
extension FeedController{
    private func setupCollectionViewFlowLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: 600)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.backgroundColor = .systemBackground  // sets the background color of the collection view.
    
        self.collectionView.delegate = self    // set the delegate of the collection view
        self.collectionView.dataSource = self  // set the data source of the collection view
        
        self.collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "cell") // !! REGISTERS THE CELL !!
        
        view.addSubview(self.collectionView)   // adds the collection view as a subsview under the main view.
        
    
        // Set constraints (using Auto Layout) ****CONSTRAINTS ARE GIVEN HERE****
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}





// MARK: - Collection View Protocols
extension FeedController : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FeedCell else{print("error") ; return UICollectionViewCell()}
        return cell
    }
}


// MARK: - LogoutButton:
extension FeedController{
    func addLogoutButtonToNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let controller = LoginController()
                let loginNavigation = UINavigationController(rootViewController: controller)
                loginNavigation.modalPresentationStyle = .fullScreen
                self.present(loginNavigation, animated: true, completion: nil)
            }
        }catch{
            print("\n CANNOT SIGN OUT")
        }
    }
}
