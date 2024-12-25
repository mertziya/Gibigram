# Gibigram

Gibigram is a fun project inspired by the famous sitcom *Gibi*, designed
with the basic structure of an Instagram-like app. Only characters from
*Gibi* can use this app, making it a unique and entertaining experience.

The primary goal of this project was to understand the development phases
of a medium-sized app while implementing modern programming practices.

## Features

- **Protocol-Oriented Programming (POP)**:  
  Used extensively to build delegates for ViewModel files, ensuring modular and reusable code.  

- **Instagram-Like Scrolling Experience**:  
  Combined `CollectionViews` and `TableViews` for smooth and dynamic scrolling, replicating Instagram's interface.  

- **Image Picking**:  
  Integrated the **YPImagePicker** library for an intuitive and user-friendly photo selection experience.  

- **Backend Services**:  
  - **Firebase**: Serves as the primary database and Backend-as-a-Service (BaaS), managing the app's core business logic.  
  - **Parse (via Back4App)**: Used exclusively for image storage, with image URLs stored in Firebase to keep logic centralized in Firebase. This approach avoids Firebase's paid storage feature.  

## Current Demo

https://github.com/user-attachments/assets/d8124dc6-88e5-4b2e-9e4a-ecb2cc637862

## Objectives

- Understand the development lifecycle of a medium-sized app.  
- Practice and implement Protocol-Oriented Programming.  
- Explore a hybrid backend approach using Firebase and Parse.  
- Create a smooth and visually appealing UI with scrolling components.

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
