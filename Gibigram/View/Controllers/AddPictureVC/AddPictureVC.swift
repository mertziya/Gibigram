//
//  AddPictureVC.swift
//  Gibigram
//
//  Created by Mert Ziya on 19.12.2024.
//

import UIKit
import YPImagePicker

class AddPictureVC: UIViewController {
    
    var didSelectImage : Bool = false
    var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pickImage()
    }
    
    @objc func pickImage() {
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.mediaType = .photo
        config.library.maxNumberOfItems = 1
        config.showsPhotoFilters = true
        
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [weak picker] items, _ in
            for item in items {
                if case let .photo(photo) = item {
                    print("Photo picked: \(photo.image)")
                    self.didSelectImage = true
                    self.selectedImage = photo.image
                }
            }
            picker?.dismiss(animated: true, completion: {
                if self.didSelectImage{
                    let vc = ShareImageVC()
                    vc.imageToUpload = self.selectedImage
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
                self.didSelectImage = false
            })
            
            if let tabBarController = self.tabBarController{
                tabBarController.selectedIndex = 0
            }
            
        }
        
        
        
        present(picker, animated: true, completion: nil)
    }
    
}


