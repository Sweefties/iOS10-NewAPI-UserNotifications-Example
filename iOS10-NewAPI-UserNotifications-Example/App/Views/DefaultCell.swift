//
//  DefaultCell.swift
//  iOS10-NewAPI-UserNotifications-Example
//
//  Created by Wlad Dicario on 22/09/2016.
//  Copyright © 2016 Sweefties. All rights reserved.
//

import UIKit


/// `DefaultCell` class
///
/// defines the attributes and behavior of the cells that appear in `UITableView` objects. 
///
class DefaultCell: UITableViewCell {

    
    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    /// Sets the selected state of the cell, optionally animating the transition between states.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //selectionStyle = .none
    }
    
    
    /// Prepares a reusable cell for reuse by the table view's delegate.
    override func prepareForReuse() {
        textLabel?.text = nil
    }
    
    
    /// Configure Cell with data model
    ///
    /// - Parameter data: `String`
    ///
    func configureCell(data: UNContent) {
        guard let content = data as UNContent? else { fatalError("something went wrong") }
        
        textLabel?.text = content.body
        detailTextLabel?.text = content.subtitle
    }
}
