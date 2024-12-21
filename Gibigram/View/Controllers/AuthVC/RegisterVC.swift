//
//  RegisterVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 21.12.2024.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var fullnameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var signInLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        addSignInGesture()
        whenClickedOutsideDismissKeyboard()
        setupSignInButtonLogic()
        setupSignInButton()
    }
    
    private func setupTextFields(){
        setupOneTextField(tf: emailTF, placeholder: "Email")
        setupOneTextField(tf: usernameTF, placeholder: "Username")
        setupOneTextField(tf: fullnameTF, placeholder: "Fullname")
        setupOneTextField(tf: passwordTF, placeholder: "Password")
    }
    
    private func setupOneTextField(tf : UITextField, placeholder :String){
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor : UIColor.label.withAlphaComponent(0.6)
        ])
        tf.layer.cornerRadius = 4
        tf.layer.borderColor = CGColor(gray: 1, alpha: 0.25)
        tf.layer.borderWidth = 0.5
        tf.clipsToBounds = true
        tf.backgroundColor = UIColor.label.withAlphaComponent(0.05)
    }

}




//MARK: - Gestures:
extension RegisterVC {
    private func addSignInGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toLoginVC))
        self.signInLabel.addGestureRecognizer(gesture)
    }
    @objc private func toLoginVC(){
        navigationController?.popViewController(animated: true)
    }
    
    
    private func whenClickedOutsideDismissKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Allows other touch events like button taps
        view.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    private func setupSignInButtonLogic(){
        self.SignInButton.isEnabled = false
        SignInButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
        SignInButton.layer.cornerRadius = 4
        
        emailTF.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        usernameTF.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        fullnameTF.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    @objc func textFieldsDidChange() {
        let isTextField1NonEmpty = !(emailTF.text?.isEmpty ?? true)
        let isTextField2NonEmpty = !(usernameTF.text?.isEmpty ?? true)
        let isTextField3NonEmpty = !(fullnameTF.text?.isEmpty ?? true)
        let isTextField4NonEmpty = !(passwordTF.text?.isEmpty ?? true)
        let shouldBeActive = isTextField1NonEmpty && isTextField2NonEmpty && isTextField3NonEmpty && isTextField4NonEmpty
        
        // Change button's background color alpha based on text fields' states
        self.SignInButton.isEnabled = shouldBeActive
    }
    
    
    private func setupSignInButton(){
        self.SignInButton.addTarget(self, action: #selector(signedIn), for: .touchUpInside)
        
    }
    
    @objc private func signedIn(){
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        guard let username = usernameTF.text else {return}
        guard let fullname = fullnameTF.text else {return}
        
        let credentials = AuthCredentials(email: email, password: password, username: username, fullname: fullname)
        
        AuthLogic.registerUser(with: credentials) { error in
            if let error = error {
                print("DEBUG : \(error.localizedDescription)")
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
}
