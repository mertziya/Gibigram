//
//  AppDelegate.swift
//  Gibigram
//
//  Created by Mert Ziya on 18.12.2024.
//

import UIKit
import FirebaseCore
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = "SQ2eVuXYhk6rxCpfnPVNgMNeKMvQMFSiLL4eZrrQ" // Replace with your App ID
            $0.clientKey = "KkB0AWjbJkmzbzDEWgyBU8BbKYzyTcC7poR1fDDS"         // Replace with your Client Key
            $0.server = "https://parseapi.back4app.com" // Replace with your Parse Server URL
        }
        Parse.initialize(with: parseConfig)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

