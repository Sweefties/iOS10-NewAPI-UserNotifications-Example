//
//  UIHelper.swift
//  iOS10-NewAPI-UserNotifications-Example
//
//  Created by Wlad Dicario on 22/09/2016.
//  Copyright © 2016 Sweefties. All rights reserved.
//

import UIKit


/// `UIHelper` helper class. 
///
final class UIHelper {
    
    
    /// Save Image with name. 
    ///
    /// to write the contents of the Data to a location.
    ///
    /// - Parameter name: `String`
    ///
    /// - Returns: `URL` optionnal
    ///
    class func saveImage(name: String) -> URL? {

        guard let image = UIImage(named: name) else {  return nil }
        
        let data = UIImagePNGRepresentation(image)
        let path = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]
        
        do {
            
            let fileURL = path.appendingPathComponent("\(name).png")
            _ = try data?.write(to: fileURL)
            
            return fileURL
            
        } catch {
            
            return nil
        }
    }
}



/// `Utils` helper class.
///
class Utils {
    
    
    /// Load Current Date to get each component from current calendar
    ///
    /// - Note: [0] = hour,
    ///         [1] = minutes,
    ///         [2] = seconds,
    ///         [3] = month,
    ///         [4] = year,
    ///         [5] = day
    ///
    /// - Returns: `[Int]` array of integer. 
    ///
    class func loadCurrentDate() -> [Int] {
        
        let date        = Date()
        let calendar    = Calendar.current
        
        let hour        = calendar.component(.hour, from: date)
        let minutes     = calendar.component(.minute, from: date)
        let seconds     = calendar.component(.second, from: date)
        let month       = calendar.component(.month, from: date)
        let year        = calendar.component(.year, from: date)
        let day         = calendar.component(.day, from: date)
        
        return [hour, minutes, seconds, month, year, day]
    }
}
