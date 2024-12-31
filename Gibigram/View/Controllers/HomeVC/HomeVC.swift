//
//  HomeVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 19.12.2024.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - UI Component:     
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties:
    var viewmodel = HomeVM()
    var homePosts : [Post]?
    var userForPost : User?
    var isWait = true // For swiping up to reload data gesture
    
    // MARK: Lifecylces:
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.delegate = self
        viewmodel.getPostsForTable()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostsCell")
        tableView.register(UINib(nibName: "StoriesCell", bundle: nil), forCellReuseIdentifier: "StoriesCell")
        
        setNavigationBar() // configures the navbar for this screen.
        tableView.showsVerticalScrollIndicator = false // hides the indicator that apears right at the tableview.
        
        tableView.alwaysBounceVertical = true
    }
    
}


// MARK: - Table View Configurations:
extension HomeVC: UITableViewDelegate, UITableViewDataSource, HomeVMDelegate, presentStoryDelegate{
    func didOpenStory(vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    func didFailWithError(error: any Error) {
        print("error")
    }
    
    func didFetchTargetedPosts(posts: [Post]?) {
        print("worked")
        
        DispatchQueue.main.async {
            self.homePosts = posts
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.homePosts?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row - 1
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoriesCell", for: indexPath) as? StoriesCell else{
                print("DEBUG: couldn't get the cell")
                return UITableViewCell()
            }
            cell.viewmodel.fetchStoriesOfFollowedUser()
            cell.delegate = self
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as? PostCell else{
                print("DEBUG: couldn't get the cell")
                return UITableViewCell()
            }
            guard let posts = self.homePosts else{return UITableViewCell()}
            
            guard let postImageURLstring = posts[index].postImageURL else{print("POST IMAGE ERROR") ; return UITableViewCell()}
            let profileImageURLstring = posts[index].profileImageURL ?? "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fgaleri2.uludagsozluk.com%2F208%2F404error_305098.jpg&f=1&nofb=1&ipt=5207989fdb42f65dd3b05537aa5ceab66d7ed6fba8a6500206eaee6d37d990d4&ipo=images"
            
            let postImageURL = URL(string: postImageURLstring)
            let profileImageURL = URL(string: profileImageURLstring)
            cell.postImage.kf.setImage(with: postImageURL)
            cell.profileImage.kf.setImage(with: profileImageURL)
            cell.postLocation.text = posts[index].postLocation
            cell.profileName.text = posts[index].fullname
            cell.likesLabel.text = "\(String(describing: posts[index].postLikes ?? 0)) Likes"
            cell.usernameLabel.text = posts[index].username
            cell.descriptionLabel.text = posts[index].postDescription
            
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 98
        }else{
            return self.view.frame.height * 0.75
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffSet = scrollView.contentOffset.y
        if yOffSet < -150 && isWait {
            print("Scrolled to the top and beyond")
            self.isWait = false
            
            viewmodel.getPostsForTable()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.isWait = true
            }
        }
    }
    
}





// MARK: - the navigationBar configuarions for te Home View Controller.
extension HomeVC {
    private func setNavigationBar(){
        let notifications = UIBarButtonItem(image: UIImage.followings, style: .plain, target: self, action: #selector(toNotifications))
        let dms = UIBarButtonItem(image: UIImage.DMS, style: .plain, target: self, action: #selector(toDMS))
        
        let camera = UIBarButtonItem(image: UIImage.camera, style: .plain, target: self, action: #selector(toCamera))
        
        dms.tintColor = UIColor.label
        notifications.tintColor = UIColor.label
        camera.tintColor = UIColor.label
        
        navigationItem.rightBarButtonItems = [dms , notifications]
        navigationItem.leftBarButtonItem = camera
        
       
        
        
        // Create an UIImageView with your image
        let iv = UIImageView(image: UIImage(named: "gibigram"))
        iv.contentMode = .scaleAspectFit
        
        // Set frame size for the UIImageView
        iv.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout for precise positioning
        
        // Create a container view for better alignment
        let containerView = UIView()
        containerView.addSubview(iv)
        // Set Auto Layout constraints for centering the UIImageView
        NSLayoutConstraint.activate([
            iv.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iv.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iv.heightAnchor.constraint(equalToConstant: 60), // Adjust height as needed
            iv.widthAnchor.constraint(equalToConstant: 100) // Adjust width as needed
        ])
        // Set the container view as the navigation item's titleView
        navigationItem.titleView = containerView
        
    }
    
    @objc private func toNotifications(){
        
    }
    
    @objc private func toDMS(){
        
    }
    
    @objc private func toCamera(){
        tabBarController?.selectedIndex = 2
    }
}
