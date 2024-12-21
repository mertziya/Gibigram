//
//  HomePage.swift
//  Gibigram
//
//  Created by Mert Ziya on 18.12.2024.
//

import Foundation
import FirebaseAuth
import UIKit

class TabController : UITabBarController {
    
    var isAuthenticated = Auth.auth().currentUser != nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTabs()
        self.tabBar.backgroundColor = .systemBackground
        self.tabBar.tintColor = .label
        
        if !isAuthenticated{ setupAuth() }
        

    }
    
 
    
    
    // MARK: - Tabbar setup:
    
    private func setupTabs(){
        // Navigation controllers that is being directed when the user selects the item from the tab bar menu.
        let homeNav = createNavs(with: "Home", and: UIImage(systemName: "house")!, vc: HomeVC())
        let searchNav = createNavs(with: "Search", and: UIImage(systemName: "magnifyingglass")!, vc: SearchVC())
        let addpictureNav = createNavs(with: "Add", and: UIImage(systemName: "plus.square")!, vc: AddPictureVC())
        let likesNav = createNavs(with: "Likes", and: UIImage(systemName: "heart")!, vc: LikesVC())
        let profileNav = createNavs(with: "Profile", and: UIImage(systemName: "person.and.background.striped.horizontal")!, vc: ProfileVC())
        
        homeNav.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        searchNav.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.sparkle")
        addpictureNav.tabBarItem.selectedImage = UIImage(systemName: "plus.square.fill")
        likesNav.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        profileNav.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        
        self.setViewControllers([homeNav, searchNav, addpictureNav, likesNav, profileNav], animated: true)

    }
    
    // Creates navigation Controller with the given VC as its root view controller.
    private func createNavs(with title: String, and image : UIImage, vc : UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        
        nav.topViewController?.navigationItem.title = "\(title) Controller"
        nav.topViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // Covers the entire area, including the status bar
        appearance.backgroundColor = .clear        // Set the background color
        
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        nav.navigationBar.compactAppearance = appearance
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
    
    
    private func setupAuth() {
        DispatchQueue.main.async {
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.isModalInPresentation = true
            
            self.present(nav, animated: true)
        }
    }
}
