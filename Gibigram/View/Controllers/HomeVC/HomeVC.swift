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
    
    
    // MARK: Lifecylces:
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostsCell")
        tableView.register(UINib(nibName: "StoriesCell", bundle: nil), forCellReuseIdentifier: "StoriesCell")
        
        setNavigationBar() // configures the navbar for this screen.
        tableView.showsVerticalScrollIndicator = false // hides the indicator that apears right at the tableview.
    }
    
}


// MARK: - Table View Configurations:
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoriesCell", for: indexPath) as? StoriesCell else{
                print("DEBUG: couldn't get the cell")
                return UITableViewCell()
            }
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as? PostCell else{
                print("DEBUG: couldn't get the cell")
                return UITableViewCell()
            }
            
            
            
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
        
    }
}
