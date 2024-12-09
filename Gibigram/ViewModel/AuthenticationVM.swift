//
//  AuthenticationVM.swift
//  IOSX-Gibigram
//
//  Created by Mert Ziya on 8.12.2024.
//

import Foundation
import UIKit


protocol authenticationViewModel{
    var formIsValid : Bool { get }
    var alphaValue : CGFloat { get }
}


struct LoginViewModel : authenticationViewModel{
    var email: String?
    var password: String?
    
    var formIsValid : Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var alphaValue : CGFloat {return formIsValid ? 1 : 0.3 }
    
}


struct registerationViewModel : authenticationViewModel{
    var email: String?
    var password: String?
    var username: String?
    var fullname: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && username?.isEmpty == false && fullname?.isEmpty == false
    }
    
    var alphaValue: CGFloat {
        return formIsValid ? 1 : 0.3
    }

}
    
    
    
    
   
    

