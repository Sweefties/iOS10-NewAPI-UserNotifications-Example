![](https://img.shields.io/badge/build-pass-brightgreen.svg?style=flat-square)
![](https://img.shields.io/badge/platform-iOS%2010+-ff69b4.svg?style=flat-square)
![](https://img.shields.io/badge/Require-XCode%208-lightgrey.svg?style=flat-square)


# iOS 10 - New API - User Notifications - 3DTouch Example
iOS 10~ Experiments - New API Components - New User Notifications with 3DTouch and iPhone 7.

## Example

![](/source/iOS10-NewAPI-UserNotifications-Example.jpg)


## Requirements

- >= XCode 8.0
- >= Swift 3.
- >= iOS 10.0.
- >= 3D Touch Devices or iOS 10 supported.

Tested on iPhone SE, iPhone 6, iPhone 7 iOS 10.0 Simulators and physicals iPhone 7, iPhone 6, iPhone SE.

## Important

This is a Xcode 8+ / Swift 3+ project.
To run on physicals devices, change the team provisioning profile.


## References

Read : [UNUserNotificationCenter](https://developer.apple.com/reference/usernotifications/unusernotificationcenter)

API Reference : [UserNotifications](https://developer.apple.com/reference/usernotifications)


## Usage

To run the example project, download or clone the repo.


### Example Code!


 Import Framework :

```
import UserNotifications
```

Register `UNUserNotificationCenter`

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

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

  return true
}
```

Set Actions and Categories :

```swift
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
```

Add request to current `UNUserNotificationCenter`

```swift
  let request = UNNotificationRequest(identifier: UNIdentifiers.request, content: content[type.rawValue], trigger: nil)
  UNUserNotificationCenter.current().add(request) { error in
    UNUserNotificationCenter.current().delegate = self
    if (error != nil){
      //handle here
    }
  }
```


Et Voilà!

- Build and Run!
- By pressing lightly (`Peek`) and pressing a little more firmly to actually open content (`Pop`)
- Optimized for Devices : iPhone 6s and others 3D Touch devices!
