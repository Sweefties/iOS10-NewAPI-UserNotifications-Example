//
//  UNIdentifiers.swift
//  iOS10-NewAPI-UserNotifications-Example
//
//  Created by Wlad Dicario on 22/09/2016.
//  Copyright © 2016 Sweefties. All rights reserved.
//

import Foundation

/// UNIdentifiers struct.
///
/// define User Notifications Identifiers
///
struct UNIdentifiers {
    
    static let request        = "requestIdentifier"
    static let reply          = "replyIdentifier"
    static let share          = "shareIdentifier"
    static let follow         = "followIdentifier"
    static let destructive    = "destructiveIdentifier"
    static let direction      = "directionIdentifier"
    static let category       = "categoryIdentifier"
    static let image          = "imageIdentifier"
    static let video          = "videoIdentifier"
    static let customContent  = "customContentIdentifier"
    
}


/// Notifications Type Enum.
///
/// define User Notifications Type enum. as `Int`
///
enum NotifType : Int {
    case rich
    case actionable
    case media
    case custom
    case delay
    case location
    case calendar
}
