//
//  CustomView.swift
//  IOSX-Gibigram
//
//  Created by Mert Ziya on 6.12.2024.
//

import UIKit
import Foundation

enum textFieldType {
    case email
    case password
    case standard
}

class CustomTextFields{
    
    
    // textfields that are used under the authorizations section at login and register page:
    static func authTextField(type : textFieldType, placeholder : String) -> UITextField{
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        // method used to give a padding inside the textfield's content and its boundaries:
        // we could also give it to the Right View.
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 10)
        textField.leftView = spacer
        textField.leftViewMode = .always
        
        textField.textColor = .white
        textField.keyboardAppearance = .default
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(50)
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)]
        )
        
        if type == .email{
            textField.keyboardType = .emailAddress
        }else if type == .password{
            textField.isSecureTextEntry = true
        }
        
        return textField
    }
    
}


