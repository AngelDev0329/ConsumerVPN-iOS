//
//  WLVPNNavigationController.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 9/13/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import UIKit
import VPNKit

class WLVPNNavigationController: UINavigationController {
    
    var apiManager: VPNAPIManager! {
        didSet {
            vpnConfiguration = apiManager.vpnConfiguration
        }
    }

    var vpnConfiguration: VPNConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign the VPNConfiguration and APIManager instances to the root view controller if it conforms to VPNStatusReporting
        if let vpnCommunicator = viewControllers.first as? VPNStatusReporting {
            vpnCommunicator.apiManager = apiManager
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // Assign the VPNConfiguration and APIManager instances to the view controller if it conforms to VPNStatusReporting
        if let vpnCommunicator = viewController as? VPNStatusReporting {
            vpnCommunicator.apiManager = apiManager
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}

