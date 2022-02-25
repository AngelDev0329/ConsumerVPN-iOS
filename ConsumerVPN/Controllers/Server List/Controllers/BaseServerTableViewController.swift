//
//  BaseServerTableViewController.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 9/26/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import UIKit
import VPNKit

class BaseServerTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let cellNib = UINib(nibName: CityServerTableViewCell.reuseIdentifier, bundle: nil)
        
        // register if our subclass is to use `dequeueReusableCellWithIdentifier(_:forIndexPath:)
        tableView.register(cellNib, forCellReuseIdentifier: CityServerTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .cellSeparator
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Set up Colors
        tableView.backgroundColor = UIColor.serverListBackground.darker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Configuration
    
    func configure(_ cell: CityServerTableViewCell, forCityModel cityModel: CityModel) {
        
        // configure cell...
        cell.cityLabel.text = "\(cityModel.name), \(cityModel.countryName)"
        cell.flagImageView.image = cityModel.flagImage
//        cell.shapeFlagToCircle()
    }
    
    func configureBestAvailable(_ cell: CityServerTableViewCell) {
        
        // configure cell...
        cell.cityLabel.text = "\(LocalizedString.bestAvailable)"
        cell.flagImageView.image = UIImage(named: "best-available")
//        cell.shapeFlagToSquare()
    }
}
