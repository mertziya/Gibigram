//
//  LoginController.swift
//  IOSX-OldInstagramClone
//
//  Created by Mert Ziya on 6.12.2024.
//

import UIKit

class LoginController: UIViewController {

    // MARK: - Properties:
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "gibigramAuthLogo"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        return CustomTextFields.authTextField(placeholder: "Email")
    }()
    
    private let passwordTextField: UITextField = {
        return CustomTextFields.authTextField(isPassword: true, placeholder: "Password")
    }()
    
    private let loginButton: UIButton = {
        return CustomButtons.loginButton()
    }()
    
    private let dontHaveAnAccount : UIButton = {
        return CustomButtons.clickableText(title: "Don't have an account? Sign In", fontSize: 12, fontWeight: .bold)
    }()
    
    private let forgotPasswordButton: UIButton = {
        return CustomButtons.clickableText(title: "Forgout your password?", fontSize: 11, fontWeight: .regular)
    }()
    
    
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    
    
    // MARK: - Helpers:
    func configureUI(){
        view.backgroundColor = .white
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor , UIColor.systemBlue.cgColor]
        gradient.locations = [0,1] // if [0,0.5] is given gradient change will stop at the half of the screen.
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.topAnchor , paddingTop: 100)
        iconImage.setDimensions(height: 75, width: 250)
        
        
        
        // initializing stack view for email,password and login button and its attributes:
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // setting stack view constraints:
        view.addSubview(stackView)
        stackView.anchor(top: iconImage.bottomAnchor , left: view.leftAnchor , right: view.rightAnchor,
                         paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.anchor(top: stackView.bottomAnchor, right: view.rightAnchor , paddingTop: 10, paddingRight: 32)
        
        
        
        
        // setting stack view for donthaveanaccount label and SignUp button and its attributes.
        view.addSubview(dontHaveAnAccount)
        dontHaveAnAccount.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor
                                 , paddingLeft: 50 , paddingBottom: 100, paddingRight: 50)
    }
    

}
