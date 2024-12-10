//
//  RegisterController.swift
//  IOSX-OldInstagramClone
//
//  Created by Mert Ziya on 6.12.2024.
//

import UIKit

class RegisterController: UIViewController {
    let imageUpload = ImageUploader()
    var registerVM = registerationViewModel()

    
    // MARK: - Properties:
    
    private let plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "PhotoAddImage"), for: .normal)
        button.layer.cornerRadius = button.frame.width / 2
        button.addTarget(nil, action: #selector(handleUploadPhoto), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private let emailField : UITextField = {
        return CustomTextFields.authTextField(type: .email, placeholder: "Email")
    }()
    
    private let passwordField : UITextField = {
        return CustomTextFields.authTextField(type: .password, placeholder: "Password")
    }()
    
    private let fullname : UITextField = {
        return CustomTextFields.authTextField(type: .standard, placeholder: "Fullname")
    }()
    
    private let username : UITextField = {
        return CustomTextFields.authTextField(type: .standard, placeholder: "Username")
    }()
    
    private lazy var signupButton : UIButton = {
        let button = CustomButtons.authButton(theTitle: "Sign Up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccount : UIButton = {
        let button = CustomButtons.clickableText(title: "Already have an account? Log in", fontSize: 12, fontWeight: .bold)
        button.addTarget(nil, action: #selector(backToLoginPage), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycles:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
        
    }
    
    // MARK: - Helpers:
    
    private func configureUI(){
        Background.setBackgroundGradient(targetView: self.view)
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top: view.topAnchor, paddingTop: 75)
        plusPhotoButton.setDimensions(height: 125, width: 125)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        emailField.delegate = self
        passwordField.delegate = self
        username.delegate = self
        fullname.delegate = self
        
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField, fullname, username, signupButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        
        
        alreadyHaveAccount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alreadyHaveAccount)
        NSLayoutConstraint.activate([
            alreadyHaveAccount.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            alreadyHaveAccount.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            alreadyHaveAccount.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }

}



// MARK: - Actions
extension RegisterController {
    
    @objc func backToLoginPage(){
        navigationController?.popViewController(animated: true)
    }
    
    func configureNotificationObservers(){
        emailField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullname.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        username.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc func textDidChange(sender : UITextField){
        if sender == emailField{
            registerVM.email = sender.text
        }else if sender == passwordField{
            registerVM.password = sender.text
        }else if sender == username{
            registerVM.username = sender.text
        }else{
            registerVM.fullname = sender.text
        }
        
        self.signupButton.alpha = registerVM.alphaValue
        self.signupButton.isEnabled = registerVM.formIsValid
        
    }
    
    @objc func handleSignUp(){
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}
        guard let username = username.text else {return}
        guard let fullname = fullname.text else {return}
        guard let profileImage = plusPhotoButton.image(for: .normal) else {return}
        
        let credentials = AuthCredentials(email: email, password: password, username: username, fullname: fullname, profileImage: profileImage)
        
        AuthService.registerUserFirebase(credentials: credentials) { error in
            if let error = error{
                print("error registiring the user" , error.localizedDescription)
                return
            }else{
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
}


extension RegisterController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @objc func handleUploadPhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else{print("error while selecting image") ; return}
        
        // Apply aspectFill to the button's imageView
        if let imageView = plusPhotoButton.imageView {
            imageView.layer.cornerRadius = imageView.frame.width / 2
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            imageView.contentMode = .scaleAspectFill
        }

        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
        
}


extension RegisterController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [
            .foregroundColor : UIColor(white: 1, alpha: 0)
        ])
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [
            .foregroundColor : UIColor(white: 1, alpha: 0.67)
        ])
    }
    
    @objc func dismissKeyboard() {
       // Dismiss the keyboard
       view.endEditing(true)
    }
    
}
