//
//  DashboardDisconnectedViewControllerDelegate.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 9/12/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import Foundation


/**
 * This protocol defines the behavior that the parent view controller should do on behalf of the 
 *      child ViewController - DashboardDisconnectedViewController
 */
protocol DashboardDisconnectedViewControllerDelegate {
    func popSelected()
    func aesSelected()
}
