//
//  AppDelegate.swift
//  iOS10-NewAPI-UserNotifications-Example
//
//  Created by Wlad Dicario on 22/09/2016.
//  Copyright © 2016 Sweefties. All rights reserved.
//

import UIKit
import UserNotifications


// ********************************
//
// MARK: - Typealias
//
// ********************************
typealias UserNotificationsExtended = AppDelegate


// ********************************
//
// MARK: - App Delegate class.
//
// ********************************
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    // ********************************
    //
    // MARK: - Properties
    //
    // ********************************
    var window: UIWindow?

    // ********************************
    //
    // MARK: - Delegates
    //
    // ********************************
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Requests the notification settings for this app.
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in

            switch settings.authorizationStatus {
            case .authorized:
                print(settings.notificationCenterSetting)
                break
            case .denied:
                print(settings.authorizationStatus)
                // alert user, it's required for this application.
                break
            case .notDetermined:
                print(settings.authorizationStatus)
                // alert user to authorize
                break
            }
        }
        
        // set user notifications.
        setUserNotifications()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        //..
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //..
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //..
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //..
    }

    func applicationWillTerminate(_ application: UIApplication) {
        //..
    }

    /// Sent to the delegate when Apple Push Notification service cannot successfully complete the registration process.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }

}


extension UserNotificationsExtended {
    
    
    /// Set User Notifications
    ///
    /// to init User Notifications Center and manage actions, categories, requests and others.. 
    ///
    func setUserNotifications() {
        
        let center = UNUserNotificationCenter.current()
        
        // define actions
        let ac1 = setAction(id: UNIdentifiers.reply, title: "Reply")
        let ac2 = setAction(id: UNIdentifiers.share, title: "Share")
        let ac3 = setAction(id: UNIdentifiers.follow, title: "Follow")
        let ac4 = setAction(id: UNIdentifiers.destructive, title: "Cancel", options: .destructive)
        let ac5 = setAction(id: UNIdentifiers.direction, title: "Get Direction")
        
        // define categories
        let cat1 = setCategory(identifier: UNIdentifiers.category, action: [ac1, ac2, ac3, ac4], intentIdentifiers: [])
        let cat2 = setCategory(identifier: UNIdentifiers.customContent, action: [ac5, ac4], intentIdentifiers: [])
        let cat3 = setCategory(identifier: UNIdentifiers.image, action: [ac2], intentIdentifiers: [], options: .allowInCarPlay)
        
        // Registers your app’s notification types and the custom actions that they support.
        center.setNotificationCategories([cat1, cat2, cat3])
        
        // Requests authorization to interact with the user when local and remote notifications arrive.
        center.requestAuthorization(options: [.badge, .alert , .sound]) { (success, error) in
            print(error?.localizedDescription)
        }
        
    }
    
    
    /// Set User Notifications Action.
    ///
    /// - Parameter id:             `String` identifier string value
    /// - Parameter title:          `String` title string value
    /// - Parameter options:        `UNNotificationActionOptions` bevavior to the action as `OptionSet`
    ///
    /// - Returns:                  `UNNotificationAction`
    ///
    private func setAction(id: String, title: String, options: UNNotificationActionOptions = []) -> UNNotificationAction {
        
        let action = UNNotificationAction(identifier: id, title: title, options: options)

        return action
    }
    
    
    /// Set User Notifications Category.
    ///
    /// - Parameter identifier:         `String`
    /// - Parameter action:             `[UNNotificationAction]` ask to perform in response to
    ///                                 a delivered notification
    /// - Parameter intentIdentifiers:  `[String]` array of `String`
    /// - Parameter options:            `[UNNotificationCategoryOptions]` handle notifications,
    ///                                 associated with this category `OptionSet`
    ///
    /// - Returns:                      `UNNotificationCategory`
    ///
    private func setCategory(identifier: String, action:[UNNotificationAction],  intentIdentifiers: [String], options: UNNotificationCategoryOptions = []) -> UNNotificationCategory {
        
        let category = UNNotificationCategory(identifier: identifier, actions: action, intentIdentifiers: intentIdentifiers, options: options)
        
        return category
    }
}
