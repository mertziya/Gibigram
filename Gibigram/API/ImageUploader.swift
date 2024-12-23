//
//  ImageUploader.swift
//  Gibigram
//
//  Created by Mert Ziya on 21.12.2024.
//

import Foundation

 import Parse



 // Logins as admin, uploads image as admin and then logsout from the admin user.
 // Parse is only used to store data on web and the url string is used inside the firebase logically.

 private struct Admin {
     static let username = "Admin"
     static let password = "admin123"
     static let email = "admin@admin.com"
 }

 struct ImageUploader {
     
     
     // MARK: - Uploads the image and gives the URL of the image under the completion:
     func uploadImage(image: UIImage, completion: @escaping (String?) -> ()) {
         // Step 1: Login as Admin
         PFUser.logInWithUsername(inBackground: Admin.username , password: Admin.password ) { (user, error) in
             if let error = error {
                 print("Login failed: \(error.localizedDescription)")
                 completion(nil)
                 return
             }
             
             print("Login successful! Welcome \(user?.username ?? "Admin").")
             
             // Step 2: Convert UIImage to JPEG data
             guard let imageData = image.jpegData(compressionQuality: 0.75) else {
                 print("Couldn't get the JPEG data from UIImage")
                 completion(nil)
                 return
             }
             
             // Step 3: Generate a unique filename
             let filename = UUID().uuidString
             
             // Step 4: Create PFFileObject
             
             guard let file = try? PFFileObject(name: "\(filename).jpg", data: imageData, contentType: "image/jpeg") else{
                 print("couldn't get the PFFileObject\n")
                 return
             }
             
             // Step 5: Save the file
             file.saveInBackground { success, error in
                 if let error = error {
                     print("Error uploading file: \(error.localizedDescription)\n")
                     completion(nil)
                     
                     // Step 7: Logout Admin user
                     self.logoutUser()
                     return
                 } else if success, let fileUrl = file.url {
                     print("File uploaded successfully with URL: \(fileUrl)\n")
                     
                     // Step 6: Create and save metadata in the 'Images' class
                     let imageObject = PFObject(className: "Images")
                     imageObject["filename"] = file // Save file reference
                     imageObject["url"] = fileUrl // Optional: Save URL as a string
                     imageObject.saveInBackground { success, error in
                         if let error = error {
                             print("Error saving image metadata: \(error.localizedDescription)\n")
                             completion(nil)
                         } else if success {
                             print("Image metadata saved successfully.\n")
                             completion(fileUrl) // Return the file URL
                         }
                         
                         // Step 7: Logout Admin user
                         self.logoutUser()
                     }
                 }
             }
         }
     }
     
     private func logoutUser() {
         PFUser.logOutInBackground { (error) in
             if let error = error {
                 print("Logout failed: \(error.localizedDescription)")
             } else {
                 print("Logout successful!")
             }
         }
     }
 }
 

