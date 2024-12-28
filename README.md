# Gibigram 🚧
![In Progress](https://img.shields.io/badge/Project-In%20Progress-yellow?style=for-the-badge)

Gibigram is a fun project inspired by the famous sitcom *Gibi*, designed
with the basic structure of an Instagram-like app. Only characters from
*Gibi* can use this app, making it a unique and entertaining experience.

The primary goal of this project was to understand the development phases
of a medium-sized app while implementing modern programming practices.
## Objectives

- Understand the development lifecycle of a medium-sized app by usin MVVM Architecture.  
- Using Protocol Oriented Programming (POP), to create Custom Delegate Patterns to use in ViewModel files for testability.
- Used Firebase for the business logic of the app and Parse(with back4app) for storing the images of the app.
- Practiced building interface both with XIB Files and programatically to have a collective understanding of User Interfaces.

## Current Demo

https://github.com/user-attachments/assets/d8124dc6-88e5-4b2e-9e4a-ecb2cc637862

## Features

- **Protocol-Oriented Programming (POP)**:  
  Used extensively to build delegates for ViewModel files, ensuring modular and reusable code.  

- **Instagram-Like Scrolling Experience**:  
  Combined `CollectionViews` and `TableViews` for smooth and dynamic scrolling, replicating Instagram's interface.  

- **Image Picking**:  
  Integrated the **YPImagePicker** library for instagram like image picking and editing experience.

- **Backend Services**:  
  - **Firebase**: Serves as the primary database and Backend-as-a-Service (BaaS), managing the app's core business logic.  
  - **Parse (via Back4App)**: Used exclusively for image storage, with image URLs stored in Firebase to keep logic centralized in Firebase. This approach avoids Firebase's paid storage feature.
 
## Status
Completed:
* Authentication Screens(Login, Register)
* Feed Screen
* ProfileScreen
* Edit Profile Screen

In Progress:
* Search Screen
* Add Image Screen
* Followings Screen
* Direct Messaging Screen (Using FirebaseMessaging)

## Installation

1. Clone the repository:  
   ```bash
   git clone https://github.com/your-repository/Gibigram.git
   pod install
   ```
