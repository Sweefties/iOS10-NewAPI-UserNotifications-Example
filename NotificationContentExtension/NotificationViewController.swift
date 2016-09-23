//
//  NotificationViewController.swift
//  NotificationContentExtension
//
//  Created by Wlad Dicario on 23/09/2016.
//  Copyright © 2016 Sweefties. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import MapKit


// ********************************
//
// MARK: - Typealias
//
// ********************************
typealias MapViewRendered = NotificationViewController


/// `NotificationViewController` Content Extension class
///
/// extends UIViewController class
///
class NotificationViewController: UIViewController, UNNotificationContentExtension {

    
    // ********************************
    //
    // MARK: - Properties
    //
    // ********************************
    var newLocation = CLLocationCoordinate2D()
    
    
    // ********************************
    //
    // MARK: - Interface
    //
    // ********************************
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var placeLabel: UILabel!
    
    
    // ********************************
    //
    // MARK: - Lifecycle
    //
    // ********************************
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        self.placeLabel.layer.cornerRadius = 5.0
        self.placeLabel.layer.masksToBounds = true
    }
    
    
    /// Called when a notification arrives for your app.
    ///
    /// - Parameter notification: `UNNotification`
    ///
    func didReceive(_ notification: UNNotification) {
        
        // render map view
        self.renderedMap("\(notification.request.content.title)", subtitle: "\(notification.request.content.body)", latitude: 41.404499, longitude: 2.174290000000042)
        
        // set attributed text for label
        let mainStr  = "  \(notification.request.content.body)\n  \(notification.request.content.subtitle)"
        let colorStr = "iOS 10 - New API"
        
        let range = (mainStr as NSString).range(of: colorStr)
        let attribute = NSMutableAttributedString.init(string: mainStr)
        attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.black , range: range)
        attribute.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 17.0), range: range)
        
        self.placeLabel.attributedText = attribute
        
    }

}


/// MapViewRendered -> NotificationViewController Extension
///
/// The `MKMapViewDelegate` protocol defines a set of optional methods that you can use to
/// receive map-related update messages
///
extension MapViewRendered : MKMapViewDelegate {
    
    /// Rendered MapView with coordinates
    ///
    /// - Parameter title:      `String`
    /// - Parameter subtitle:   `String`
    /// - Parameter latitude:   `Double`
    /// - Parameter longitude:  `Double`
    ///
    fileprivate func renderedMap(_ title:String, subtitle:String, latitude:Double, longitude:Double) {
        newLocation.latitude = latitude
        newLocation.longitude = longitude
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: newLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = newLocation
        annotation.title = title
        annotation.subtitle = subtitle
        
        mapView.addAnnotation(annotation)
    }
}
