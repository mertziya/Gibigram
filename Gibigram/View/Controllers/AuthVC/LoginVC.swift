//
//  LoginVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 21.12.2024.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgetPassword: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldConfigurations()
        addSignupGesture()
        whenClickedOutsideDismissKeyboard()
        setupLoginButtonLogic()
        setupLoginButton()
    }

}


extension LoginVC {
    private func textfieldConfigurations(){
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [
            .foregroundColor : UIColor.label.withAlphaComponent(0.6)
        ])
        
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
            .foregroundColor : UIColor.label.withAlphaComponent(0.6)
        ])
        emailTextField.layer.cornerRadius = 4
        emailTextField.layer.borderColor = CGColor(gray: 1, alpha: 0.25)
        emailTextField.layer.borderWidth = 0.5
        emailTextField.clipsToBounds = true
        emailTextField.backgroundColor = UIColor.label.withAlphaComponent(0.05)
        
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.layer.borderColor = CGColor(gray: 1, alpha: 0.25)
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.clipsToBounds = true
        passwordTextField.backgroundColor = UIColor.label.withAlphaComponent(0.05)
    }
}



// MARK: - Gestures:
extension LoginVC {
    private func addSignupGesture(){
        let signupTapped = UITapGestureRecognizer(target: self, action: #selector(gotoRegister))
        self.signUpLabel.addGestureRecognizer(signupTapped)
    }
    
    @objc private func gotoRegister(){
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func whenClickedOutsideDismissKeyboard(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    
    private func setupLoginButtonLogic(){
        self.loginButton.isEnabled = false
        loginButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
        loginButton.layer.cornerRadius = 4
        
        emailTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    @objc func textFieldsDidChange() {
        let isTextField1NonEmpty = !(emailTextField.text?.isEmpty ?? true)
        let isTextField2NonEmpty = !(passwordTextField.text?.isEmpty ?? true)
        let shouldBeActive = isTextField1NonEmpty && isTextField2NonEmpty
        
        // Change button's background color alpha based on text fields' states
        self.loginButton.isEnabled = shouldBeActive
    }
    
    private func setupLoginButton(){
        self.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    @objc private func loginButtonTapped(){
        AuthLogic.loginUser(email: self.emailTextField.text!, password: passwordTextField.text!) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                
                let alertController = UIAlertController(
                    title: "Error!"
                    ,message: error.localizedDescription,
                    preferredStyle: .alert
                )
                
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
