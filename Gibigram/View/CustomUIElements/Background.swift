//
//  background.swift
//  IOSX-Gibigram
//
//  Created by Mert Ziya on 7.12.2024.
//

import Foundation
import UIKit

class Background{
    
    static func setBackgroundGradient(targetView: UIView){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor , UIColor.systemBlue.cgColor]
        gradient.locations = [0,1] // if [0,0.5] is given gradient change will stop at the half of the screen.
        targetView.layer.addSublayer(gradient)
        gradient.frame = targetView.frame
        
    }
    
}
