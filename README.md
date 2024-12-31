# Gibigram 🚧
![In Progress](https://img.shields.io/badge/Project-In%20Progress-yellow?style=for-the-badge)

## Project Overview
Gibigram is a project I built to learn and experiment with developing a mid-sized app. It’s inspired by Instagram but with a unique twist—it features characters from the popular sitcom “Gibi”, adding a playful and fun element to the experience.

The primary focus of this project was to explore new development concepts, enhance my skills in building user-friendly interfaces, and gain hands-on experience with integrating backends and designing dynamic features.

## Project Demo:

_*Demo Video*_ :  https://www.dropbox.com/scl/fi/jdbtfjeioq6zlakm5ajwc/CurrentDemoGibigram.mp4?rlkey=mg5b52eoqj60ik4fff61nyyn4&st=vluox4xp&dl=0

<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/user-attachments/assets/6b7666fc-f80a-4438-be47-c5fa5acff31e" alt="Login Screen" width="200">
  <img src="https://github.com/user-attachments/assets/9a6dcd1e-e876-4309-a7c2-c65b142c9ab4" alt="Profile Screen" width="200">
  <img src="https://github.com/user-attachments/assets/c2029f2f-fb3f-4ac3-bbc7-30f3006f1a6a" alt="Home Screen" width="200">
</div>

## DESIGN FILE INSPIRED: 
https://www.figma.com/design/wxhhC2SYYhbdJPZPWoAll3/Instagram-UI-Screens-(Community)?node-id=0-2&p=f&t=xt6upVg6SlvItgRG-0

## OBJECTIVES LEARNED:
- Using Programmatic UI to build Custom Views and User Interfaces.
- Using XIB Files to build User Interface
- Using Protocols to communicate between View and ViewModels, also between viewcontrollers
- Using didSet to update the UI when needed
- Details about collectionView and TableViews
- Writing Service Functions with closures (Firebase is commonly used).
- Using 2 backends Service Providers under one Project (Parse and Firebase).
- Delegate Patterns and Singleton Patterns
- Creating Custom Reusable Views both programitaclly and with XIB Files.
- MVVM Architecture
- Using Delegate Patterns to present a ViewController from a CollectionViewCell or TableViewCell.
- Swiping Up to Reload data in table View. Even though there is not enough items in table view (always bounce)
- Swiping Down to Dismiss a view Controller even though it is presented modally in fullscreen.
- Setting up the UI Design and layoutaccording to Design made by designer (figma in this case)
- Designing UML diagrams to make the business logic of the app with the help of Firebase Firestore.
- Used YPImagePicker third party library to have an instagram like image picking interface
- Using UIResponder for showing/hiding keyboard, together with notification pattern -UINotification- 



## THINGS THAT CAN BE IMPROVED:
* Better Naming structring of the folders.
* Used Nested Closures on some part of the code
* Could be better at using DispatchGroup while coding services.
* Notification Design Pattern Could be studied

## POTENTIAL UPDATES ABOUT THE PROJECT:
* Comment Section: where users can make comments to the posts. Comment will be stored as an array of dictionaries, including username as a key and comment as a value inside the dictionary of the array.
* Liking Logic: a user should only like a post for once, so the post needs to have a liked by section with an array of users and if the person that is liking is currently inside that array that user should not be able to like that picture.
* Direct Messaging with Firebase massaging
