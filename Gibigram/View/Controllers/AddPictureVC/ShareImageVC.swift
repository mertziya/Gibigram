//
//  ShareImageVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 29.12.2024.
//

import Foundation
import UIKit


class ShareImageVC: UIViewController {
    // MARK: - UI Components:
    
    let backButton = UIButton()
    let sharingImageView = UIImageView()
    
    let uploadType = UISegmentedControl()
    
    // Story View:
    var storyView = UIView()
    var storyDescription = UITextField()
    
    // Post View:
    var postView = UIView()
    var postDescription = UITextField()
    var location = UITextField()
    
    var uploadButton = UIButton()
    
    
    // MARK: - Properties:
    
    let viewmodel = ShareImageVM()
    var imageToUpload : UIImage?
    
    
    // MARK: - Lifecycles:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        backButton.addTarget(self, action: #selector(closeWindow), for: .touchUpInside)
        uploadType.addTarget(self, action: #selector(showView(_:)), for: .valueChanged)
        uploadButton.addTarget(self, action: #selector(addImageToDB), for: .touchUpInside)
        
        setKeyboardRelatedProperties()
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    @objc private func closeWindow(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func showView(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0: storyView.isHidden = true; postView.isHidden = false // shows the postView on first segment
        case 1: storyView.isHidden = false; postView.isHidden = true // shows the storyView on second segment
        default: storyView.isHidden = true; postView.isHidden = false
        }
    }
    
    @objc private func addImageToDB(){
        guard let imageToUpload = self.imageToUpload else{return}
        if uploadType.selectedSegmentIndex == 0{
            print("post uploaded")
            viewmodel.loadPost(selectedImage: imageToUpload, postDescription: postDescription.text ?? "", postLocation: location.text ?? "")
        }else {
            print("story uploaded")
            viewmodel.loadStory(selectedImage: imageToUpload, storyDescription: storyDescription.text ?? "")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK: - Configuration of textfields and keyboard:
extension ShareImageVC : UITextFieldDelegate{
    
    private func setKeyboardRelatedProperties(){
        postDescription.delegate = self
        location.delegate = self
        storyDescription.delegate = self
                
        let dismisGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismisGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == postDescription {
            textField.placeholder = "   Enter Description"
        }else if textField == location{
            textField.placeholder = "   Enter Location"
        }else if storyDescription == textField{
            textField.placeholder = "   Enter Description"
        }
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let keyboardHeight = keyboardFrame.height
                
                // Move the view up by the keyboard height
                if view.frame.origin.y == 0 {
                    view.frame.origin.y -= keyboardHeight
                }
            }
        }
        
    @objc func keyboardWillHide(_ notification: Notification) {
        // Reset the view's position
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}



extension ShareImageVC {
    private func setupUI(){
        view.addSubview(backButton)
        view.addSubview(sharingImageView)
        view.addSubview(uploadType)
        
        view.addSubview(storyView)
        view.addSubview(postView)
        storyView.addSubview(storyDescription)
        postView.addSubview(location)
        postView.addSubview(postDescription)
        
        view.addSubview(uploadButton)
        
        postView.backgroundColor = .clear
        storyView.backgroundColor = .clear
        storyView.isHidden = true; postView.isHidden = false // default configuration.
        
        // MARK: - UI Config:
        backButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        backButton.tintColor = .label
        
        sharingImageView.contentMode = .scaleAspectFit
        sharingImageView.image = self.imageToUpload ?? UIImage(systemName: "photo")
        sharingImageView.clipsToBounds = true
        
        uploadType.insertSegment(withTitle: "Post", at: 0, animated: true)
        uploadType.insertSegment(withTitle: "Story", at: 1, animated: true)
        uploadType.selectedSegmentIndex = 0 // Default Segment
        
        
        postDescription.attributedPlaceholder = NSAttributedString(string: "   Enter Description", attributes: [
            .foregroundColor : UIColor.label
        ])
        postDescription.layer.cornerRadius = 8
        postDescription.layer.borderWidth = 1
        postDescription.layer.borderColor = CGColor(gray: 0.6, alpha: 0.5)
        postDescription.backgroundColor = .systemBackground
        
        
        location.attributedPlaceholder = NSAttributedString(string: "   Enter Location", attributes: [
            .foregroundColor : UIColor.label
        ])
        location.layer.cornerRadius = 8
        location.layer.borderWidth = 1
        location.layer.borderColor = CGColor(gray: 0.6, alpha: 0.5)
        location.backgroundColor = .systemBackground
        
        storyDescription.attributedPlaceholder = NSAttributedString(string: "   Enter Description", attributes: [
            .foregroundColor : UIColor.label
        ])
        storyDescription.layer.cornerRadius = 8
        storyDescription.layer.borderWidth = 1
        storyDescription.layer.borderColor = CGColor(gray: 0.6, alpha: 0.5)
        storyDescription.backgroundColor = .systemBackground
        
        uploadButton.setTitle("Share", for: .normal)
        uploadButton.setTitleColor(.label, for: .normal)
        uploadButton.backgroundColor = .link
        uploadButton.layer.cornerRadius = 8
       

        
        
        
        // MARK: - Constraints
        backButton.translatesAutoresizingMaskIntoConstraints = false
        sharingImageView.translatesAutoresizingMaskIntoConstraints = false
        uploadType.translatesAutoresizingMaskIntoConstraints = false
        storyView.translatesAutoresizingMaskIntoConstraints = false
        postView.translatesAutoresizingMaskIntoConstraints = false
        storyDescription.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            backButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            sharingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            sharingImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            sharingImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            sharingImageView.heightAnchor.constraint(equalToConstant: view.frame.width),
            
            uploadType.topAnchor.constraint(equalTo: sharingImageView.bottomAnchor, constant: 0),
            uploadType.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            uploadType.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            uploadType.heightAnchor.constraint(equalToConstant: 44),
            
            postView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            postView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            postView.topAnchor.constraint(equalTo: uploadType.bottomAnchor, constant: 0),
            postView.heightAnchor.constraint(equalToConstant: 140),
            
            storyView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            storyView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            storyView.topAnchor.constraint(equalTo: uploadType.bottomAnchor, constant: 0),
            storyView.heightAnchor.constraint(equalToConstant: 140),
            
            postDescription.topAnchor.constraint(equalTo: postView.topAnchor, constant: 12),
            postDescription.leftAnchor.constraint(equalTo: postView.leftAnchor, constant: 12),
            postDescription.rightAnchor.constraint(equalTo: postView.rightAnchor, constant: -12),
            postDescription.heightAnchor.constraint(equalToConstant: 48),
            
            location.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 12),
            location.leftAnchor.constraint(equalTo: postView.leftAnchor, constant: 12),
            location.rightAnchor.constraint(equalTo: postView.rightAnchor, constant: -12),
            location.heightAnchor.constraint(equalToConstant: 48),
            
            storyDescription.topAnchor.constraint(equalTo: storyView.topAnchor, constant: 12),
            storyDescription.leftAnchor.constraint(equalTo: storyView.leftAnchor, constant: 12),
            storyDescription.rightAnchor.constraint(equalTo: storyView.rightAnchor, constant: -12),
            storyDescription.heightAnchor.constraint(equalToConstant: 48),
            
            
            uploadButton.topAnchor.constraint(equalTo: uploadType.bottomAnchor, constant: 140),
            uploadButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            uploadButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            uploadButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
