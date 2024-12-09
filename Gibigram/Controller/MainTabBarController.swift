//
//  MainTabBarController.swift
//  IOSX-OldInstagramClone
//
//  Created by Mert Ziya on 5.12.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        
    }
    
}



// MARK: - Configure the Tabbar destinations:
extension MainTabBarController{

    func configureViewControllers(){
        
        
        let feed = templateNavigationController(unselectedImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, rootViewController: FeedController())
        
        let search = templateNavigationController(unselectedImage: UIImage(systemName: "magnifyingglass")!, selectedImage: UIImage(systemName: "magnifyingglass")!, rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(unselectedImage: UIImage(systemName: "plus.app")!, selectedImage: UIImage(systemName: "plus")!, rootViewController: ImageSelectorController())
        
        let notification = templateNavigationController(unselectedImage: UIImage(systemName: "heart")!, selectedImage: UIImage(systemName: "heart.fill")!, rootViewController: NotificationController())
        
        let profile = templateNavigationController(unselectedImage: UIImage(systemName: "person.crop.circle")!, selectedImage: UIImage(systemName: "person.crop.circle.fill")!, rootViewController: ProfileController())
        
        viewControllers = [feed, search , imageSelector, notification , profile] // the segueway for other viewcontrollers listed on tabbar
       
        
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .systemGray2
        
        
    }
    
    func templateNavigationController(unselectedImage: UIImage , selectedImage : UIImage , rootViewController: UIViewController) -> UINavigationController{
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.image = unselectedImage          // sets the deffault image of the tabbar item.
        nav.tabBarItem.selectedImage = selectedImage    // sets the selected image of the tabbar item.
    
        nav.navigationBar.tintColor = .black // sets the color of the items that are going to be placed inside the navigation view.
        
        return nav
    }
    
}
