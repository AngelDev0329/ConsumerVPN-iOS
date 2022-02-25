//
//  FilterTableHeaderView.swift
//  ConsumerVPN
//
//  Created by Amir Nazari on 9/14/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import UIKit

class FilterTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var backgroundViewOutlet: UIView!
    
    static let reuseIdentifier = "\(FilterTableHeaderView.self)"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Setup Colors
        headerLabel.textColor = .optionsFont
        backgroundViewOutlet.backgroundColor = .filterBackground
    }
}
