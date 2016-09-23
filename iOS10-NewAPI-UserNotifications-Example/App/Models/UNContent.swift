//
//  UNContent.swift
//  iOS10-NewAPI-UserNotifications-Example
//
//  Created by Wlad Dicario on 22/09/2016.
//  Copyright © 2016 Sweefties. All rights reserved.
//

import Foundation
import UserNotifications


/// `UNContent` class model 
///
/// `UNMutableNotificationContent` editable content
///
final class UNContent: UNMutableNotificationContent {
    
    // ********************************
    //
    // MARK: - Initializer
    //
    // ********************************
    
    /// Init alert like a payload.
    init(title: String, subTitle: String, body: String) {
        
        super.init()
        
        self.title      = title
        self.subtitle   = subTitle
        self.body       = body
        self.sound      = UNNotificationSound.default()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
