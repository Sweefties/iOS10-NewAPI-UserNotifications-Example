//
//  MainVC.swift
//  iOS10-NewAPI-UserNotifications-Example
//
//  Created by Wlad Dicario on 22/09/2016.
//  Copyright © 2016 Sweefties. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import CoreLocation


// ********************************
//
// MARK: - Typealias
//
// ********************************

/// `UITableViewDataSource` protocol typealias
typealias MainTableViewDataSource   = MainVC
/// `UITableViewDelegate` protocol typealias
typealias MainTableViewDelegate     = MainVC
/// `UNUserNotificationCenterDelegate` protocol typealias
typealias UNCenterDelegate          = MainVC



/// `MainVC` class as `UIViewController`
///
/// a controller class to manage list of User Notifications and display them. 
///
class MainVC: UIViewController {

    
    
    // ********************************
    //
    // MARK: - Properties
    //
    // ********************************
    let cellID = "DefaultCell"
    let location = CLLocationManager()
    var content = [UNContent]()
    
    // ********************************
    //
    // MARK: - Interface
    //
    // ********************************
    @IBOutlet weak var tableView: UITableView!
    
    
    // ********************************
    //
    // MARK: - Lifecycle
    //
    // ********************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTableView()
        setRegisterCell()
        layoutData()
    }
    
    
    
    
    
    /// Set Table View
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = 70
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    
    /// Set Register Cell for Nib files.
    func setRegisterCell() {
        self.tableView.register(UINib.init(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    
    /// Layout Data `UNContent`
    func layoutData() {
        content.append(UNContent(title: "Simple User Notifications",
                                 subTitle: "iOS 10 - New API",
                                 body: "Rich notification : standard"))
        
        content.append(UNContent(title: "Action User Notifications",
                                 subTitle: "iOS 10 - New API",
                                 body: "Actionable notification : add some actions"))
        
        content.append(UNContent(title: "Media User Notifications",
                                 subTitle: "iOS 10 - New API",
                                 body: "Media notification : image, gif or video"))
        
        content.append(UNContent(title: "Custom User Notifications",
                                 subTitle: "iOS 10 - New API",
                                 body: "Custom notification : custom content extension"))
        
        content.append(UNContent(title: "Delayed User Notifications",
                                 subTitle: "iOS 10 - New API",
                                 body: "Delay notification : delivered with a delay"))
        
        content.append(UNContent(title: "Location User Notifications",
                                 subTitle: "iOS 10 - New API",
                                 body: "Location notification : entry/exit in region"))
        
        content.append(UNContent(title: "Calendar User Notifications",
                                 subTitle: "iOS 10 - New API",
                                 body: "Calendar notification : fire date"))
    }
    
    
    /// Show Notification With Content For IndexPath
    ///
    /// - Parameter path: `IndexPath`
    ///
    func showNotificationWithContent(path: IndexPath) {
        
        
        guard let type = NotifType(rawValue: path.row) as NotifType? else { return }
        
        switch type {
            
        case .rich:
            let request = UNNotificationRequest(identifier: UNIdentifiers.request, content: content[type.rawValue], trigger: nil)
            UNUserNotificationCenter.current().add(request) { error in
                UNUserNotificationCenter.current().delegate = self
                if (error != nil){
                    //handle here
                }
            }
            break
            
        case .actionable:
            content[type.rawValue].categoryIdentifier = UNIdentifiers.category
            let request = UNNotificationRequest(identifier: UNIdentifiers.request, content: content[type.rawValue], trigger: nil)
            UNUserNotificationCenter.current().add(request) { error in
                UNUserNotificationCenter.current().delegate = self
                if (error != nil){
                    //handle here
                }
            }
            break
            
        case .media:
            guard let url = UIHelper.saveImage(name: "w01") else { return }

            let attachment = try? UNNotificationAttachment(identifier: UNIdentifiers.image,
                                                           url: url,
                                                           options: [:])
            
            if let attachment = attachment {
                content[type.rawValue].attachments.removeAll(keepingCapacity: true)
                content[type.rawValue].attachments.append(attachment)
            }
            content[type.rawValue].categoryIdentifier = UNIdentifiers.image
            let request = UNNotificationRequest(identifier: UNIdentifiers.request, content: content[type.rawValue], trigger: nil)
            UNUserNotificationCenter.current().add(request) { error in
                UNUserNotificationCenter.current().delegate = self
                if (error != nil){
                    //handle here
                }
            }
            break
            
        case .custom:
            content[type.rawValue].categoryIdentifier = UNIdentifiers.customContent
            let request = UNNotificationRequest(identifier: UNIdentifiers.request, content: content[type.rawValue], trigger: nil)
            UNUserNotificationCenter.current().add(request) { error in
                UNUserNotificationCenter.current().delegate = self
                if (error != nil){
                    //handle here
                }
            }
            break
            
        case .delay:
            // Triggers the delivery of a local notification after the specified amount of time.
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UNIdentifiers.request, content: content[type.rawValue], trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                UNUserNotificationCenter.current().delegate = self
                if (error != nil){
                    //handle here
                }
            }
            break
            
        case .location:
            // Triggers the delivery of a notification when the user reaches the specified geographic location.
            setLocation()
            let center = CLLocationCoordinate2DMake(37.785834, -122.406417)
            let region = CLCircularRegion.init(center: center, radius: 100.0, identifier: "Headquarters")
            region.notifyOnEntry = true
            region.notifyOnExit = true
            let trigger = UNLocationNotificationTrigger.init(region: region, repeats: false)
            let request = UNNotificationRequest(identifier: UNIdentifiers.request, content: content[type.rawValue], trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                UNUserNotificationCenter.current().delegate = self
                if (error != nil){
                    //handle here
                }
            }
            break
            
        case .calendar:
            // Triggers a notification at the specified fire date and time
            var date = DateComponents()
            date.hour   = Utils.loadCurrentDate()[0]
            date.minute = Utils.loadCurrentDate()[1]
            // we keep the current date by adding 10 seconds only.
            date.second = Utils.loadCurrentDate()[2] + 10
            
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: date, repeats: true)
            let request = UNNotificationRequest(identifier: UNIdentifiers.request, content: content[type.rawValue], trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                UNUserNotificationCenter.current().delegate = self
                if (error != nil){
                    //handle here
                }
            }
            break
        }
    }
    
    
    
    
    /// Set Location requests permissions.
    func setLocation() {
        // NSLocationWhenInUseUsageDescription key in info.plist required
        location.requestWhenInUseAuthorization()
    }
    
    
    // ********************************
    //
    // MARK: - Memory Warning
    //
    // ********************************
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


/// UITableViewDataSource Extension.
extension MainTableViewDataSource : UITableViewDataSource {
    
    
    /// Asks the data source to return the number of sections in the table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    /// Tells the data source to return the number of rows in a given section of a table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    
    /// Asks the data source for a cell to insert in a particular location of the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DefaultCell
        
        let row = content[indexPath.row]
        cell.configureCell(data: row)
        return cell
    }
}


/// UITableViewDelegate Extension.
extension MainTableViewDelegate : UITableViewDelegate {
    
    
    /// Tells the delegate that the specified row is now selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        default: self.showNotificationWithContent(path: indexPath)
        }
    }
}


/// UNUserNotificationCenterDelegate Extension.
/// Handles notification-related interactions for your app or app extension.
extension UNCenterDelegate: UNUserNotificationCenterDelegate {
    
    
    /// Called when a notification is delivered to a foreground app
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        completionHandler( [.alert, .badge, .sound])
    }
    
    
    /// Called to let your app know which action was selected by the user for a given notification.
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        print("action selected for notification : \(response.actionIdentifier)")
    }
}
