//
//  File.swift
//  Gibigram
//
//  Created by Mert Ziya on 24.12.2024.
//

import Foundation
import UIKit

class EditProfileVC : UIViewController{
    // MARK: - Properties:
    private var changeUsername : UITextField!
    private var changeFullname : UITextField!
    private var changeSummary : UITextField!
    
    private var usernameButton : UIButton!
    private var fullnameButton : UIButton!
    private var summaryButton : UIButton!
    
    
    // MARK: - Lifecycles:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        changeUsernameConfig() // constraints and layouts for username Textfield
        changeFullnameConfig() // constraints and layouts for changeFullname Textfield
        changeSummaryConfig()  // constraints and layouts for changeSumary Textfield
        
        usernameButtonConfig() // constraints and layouts for usernameButton
        fullnameButtonConfig() // constraints and layouts for fullnameButton
        summaryButtonConfig()  // constraints and layouts for summaryButton
        
        buttonActions() // Adds the adction to buttons for sending data to firestore
    }
    
    private func changeUsernameConfig(){
        changeUsername = UITextField()
        changeUsername.placeholder = "  Change Username"
        changeUsername.layer.borderWidth = 1
        changeUsername.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        changeUsername.layer.cornerRadius = 8
        changeUsername.backgroundColor = .label.withAlphaComponent(0.1)
        
        view.addSubview(changeUsername)
        changeUsername.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeUsername.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            changeUsername.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            changeUsername.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            changeUsername.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func changeFullnameConfig(){
        changeFullname = UITextField()
        changeFullname.placeholder = "  Change Fullname"
        changeFullname.layer.borderWidth = 1
        changeFullname.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        changeFullname.layer.cornerRadius = 8
        changeFullname.backgroundColor = .label.withAlphaComponent(0.1)

        
        view.addSubview(changeFullname)
        changeFullname.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeFullname.topAnchor.constraint(equalTo: changeUsername.bottomAnchor, constant: 36),
            changeFullname.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            changeFullname.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            changeFullname.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func changeSummaryConfig(){
        changeSummary = UITextField()
        changeSummary.placeholder = "  Change Summary"
        changeSummary.layer.borderWidth = 1
        changeSummary.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        changeSummary.layer.cornerRadius = 8
        changeSummary.backgroundColor = .label.withAlphaComponent(0.1)

        
        view.addSubview(changeSummary)
        changeSummary.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeSummary.topAnchor.constraint(equalTo: changeFullname.bottomAnchor, constant: 36),
            changeSummary.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            changeSummary.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            changeSummary.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func usernameButtonConfig(){
        usernameButton = UIButton()
        usernameButton.setTitle("Edit", for: .normal)
        usernameButton.tintColor = .label.withAlphaComponent(0.1)
        usernameButton.backgroundColor = .systemBlue.withAlphaComponent(0.8)
        usernameButton.layer.cornerRadius = 8
        
        view.addSubview(usernameButton)
        usernameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            usernameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            usernameButton.leftAnchor.constraint(equalTo: changeUsername.rightAnchor, constant: 20),
            usernameButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    private func fullnameButtonConfig(){
        fullnameButton = UIButton()
        fullnameButton.setTitle("Edit", for: .normal)
        fullnameButton.tintColor = .label.withAlphaComponent(0.1)
        fullnameButton.backgroundColor = .systemBlue.withAlphaComponent(0.8)
        fullnameButton.layer.cornerRadius = 8
        
        view.addSubview(fullnameButton)
        fullnameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fullnameButton.topAnchor.constraint(equalTo: usernameButton.bottomAnchor, constant: 36),
            fullnameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            fullnameButton.leftAnchor.constraint(equalTo: changeFullname.rightAnchor, constant: 20),
            fullnameButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func summaryButtonConfig(){
        summaryButton = UIButton()
        summaryButton.setTitle("Edit", for: .normal)
        summaryButton.tintColor = .label.withAlphaComponent(0.1)
        summaryButton.backgroundColor = .systemBlue.withAlphaComponent(0.8)
        summaryButton.layer.cornerRadius = 8
        
        view.addSubview(summaryButton)
        summaryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryButton.topAnchor.constraint(equalTo: fullnameButton.bottomAnchor, constant: 36),
            summaryButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            summaryButton.leftAnchor.constraint(equalTo: changeSummary.rightAnchor, constant: 20),
            summaryButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}



// MARK: - Actions:
extension EditProfileVC {
    private func buttonActions(){
        self.usernameButton.addTarget(self, action: #selector(updateUsername), for: .touchUpInside)
        self.fullnameButton.addTarget(self, action: #selector(updateFullname), for: .touchUpInside)
        self.summaryButton.addTarget(self, action: #selector(updateSummary), for: .touchUpInside)

    }
    
    @objc private func updateUsername(){
        guard let theUsername = changeUsername.text else {
            print("Nil value"); return
        }
        
        if theUsername == "" {
            let alert = UIAlertController(title: "Error!", message: "Username cannot be empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
        }else{
            UserService.updateUsername(withNew: theUsername) { result in
                switch result{
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                case .success():
                    print("success.")
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func updateFullname(){

        guard let theFullname = changeFullname.text else {
            print("Nil value"); return
        }
        
        if theFullname == "" {
            let alert = UIAlertController(title: "Error!", message: "Fullname cannot be empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
        }else{
            UserService.updateFullname(withNew: theFullname) { result in
                switch result{
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                case .success():
                    print("success.")
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func updateSummary(){
        guard let theSummary = changeSummary.text else {
            print("Nil value"); return
        }
        
        if theSummary == "" {
            let alert = UIAlertController(title: "Error!", message: "Summary cannot be empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
        }else{
            UserService.updateSummary(withNew: theSummary) { result in
                switch result{
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                case .success():
                    print("success.")
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
