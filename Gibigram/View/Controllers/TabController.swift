//
//  HomePage.swift
//  Gibigram
//
//  Created by Mert Ziya on 18.12.2024.
//

import Foundation
import UIKit

class TabController : UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
        self.tabBar.backgroundColor = .systemBackground
        self.tabBar.tintColor = .green
    }
    
    
    // MARK: - Tabbar setup:
    
    private func setupTabs(){
        // Navigation controllers that is being directed when the user selects the item from the tab bar menu.
        let homeNav = createNavs(with: "Home", and: UIImage.homeScreen, vc: HomeVC())
        let searchNav = createNavs(with: "Search", and: UIImage.search, vc: SearchVC())
        let addpictureNav = createNavs(with: "Add", and: UIImage.addPicture, vc: AddPictureVC())
        let likesNav = createNavs(with: "Likes", and: UIImage.followings, vc: LikesVC())
        let profileNav = createNavs(with: "Profile", and: UIImage(systemName: "person.crop.circle")!, vc: ProfileVC())
        
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
    
}
