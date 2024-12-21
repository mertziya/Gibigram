//
//  ProfileVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 19.12.2024.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        configureNavigationBar()
    }


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
