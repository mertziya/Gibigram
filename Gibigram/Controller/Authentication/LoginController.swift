//
//  LoginController.swift
//  IOSX-OldInstagramClone
//
//  Created by Mert Ziya on 6.12.2024.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - UI Components:

    private var loginVM = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "gibigramAuthLogo"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var authStack : UIStackView!
    
    private let emailTextField: UITextField = {
        return CustomTextFields.authTextField(type: .email, placeholder: "Email")
    }()
    
    private let passwordTextField: UITextField = {
        return CustomTextFields.authTextField(type: .password , placeholder: "Password")
    }()
    
    private lazy var loginButton: UIButton = {
        let button = CustomButtons.authButton(theTitle: "Sign In")
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
        
    private let dontHaveAnAccount : UIButton = {
        let button = CustomButtons.clickableText(title: "Don't have an account? Sign In", fontSize: 12, fontWeight: .bold)
        button.addTarget(nil, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        return CustomButtons.clickableText(title: "Forgout your password?", fontSize: 11, fontWeight: .regular)
    }()
    
    
    
    
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        configureUI()
        configureNotificationObservers()
        tapOutsideKeyboard()
        
        
    }
    
}




// MARK: - UI Configurations:
extension LoginController {
    
    func configureUI(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        Background.setBackgroundGradient(targetView: self.view)
        
        setIconImage()
        setAuthStack()
        setForgotPassword()
        setDontHaveAnAccount()
        
    }
    
    
    func setIconImage(){
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.topAnchor , paddingTop: 100)
        iconImage.setDimensions(height: 75, width: 250)
    }
    
    func setAuthStack(){
        // initializing stack view for email,password and login button and its attributes:
        authStack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        authStack.axis = .vertical
        authStack.spacing = 20
        
        // setting stack view constraints:
        view.addSubview(authStack)
        authStack.anchor(top: iconImage.bottomAnchor , left: view.leftAnchor , right: view.rightAnchor,
                         paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    func setForgotPassword(){
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.anchor(top: authStack.bottomAnchor, right: view.rightAnchor , paddingTop: 10, paddingRight: 32)
    }
    
    func setDontHaveAnAccount(){
        // setting stack view for donthaveanaccount label and SignUp button and its attributes.
        dontHaveAnAccount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dontHaveAnAccount)
        NSLayoutConstraint.activate([
            dontHaveAnAccount.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dontHaveAnAccount.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            dontHaveAnAccount.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
   
    
}





// MARK: - Actions:
extension LoginController {
    @objc func handleShowSignUp(){ // cannot push view controller because the loginController is present not navigation.
        let controller = RegisterController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    @objc func textDidChange(sender : UITextField){
        if sender == emailTextField{
            loginVM.email = sender.text
        }else{
            loginVM.password = sender.text
        }
        
        self.loginButton.alpha = loginVM.alphaValue
        self.loginButton.isEnabled = loginVM.formIsValid
    }
    
    @objc func handleLogin(){
        AuthService.loginUserFirebase(email: emailTextField.text!, password: passwordTextField.text!) { error in
            if let error = error{
                print("there is error: \(error.localizedDescription)")
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}




// MARK: - handling the text fields

extension LoginController : UITextFieldDelegate {
    
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
    
    func tapOutsideKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside))
        view.addGestureRecognizer(tapGesture)
    }
        
    @objc func tapOutside(){
        view.endEditing(true)
    }
    
}
