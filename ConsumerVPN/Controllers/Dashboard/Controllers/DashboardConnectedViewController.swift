//
//  DashboardConnectedViewController.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 9/12/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import UIKit
import VPNKit

final class DashboardConnectedViewController: UIViewController {

    // MARK: IBOutlets and Variables
    @IBOutlet weak var visibleLocationLabel: UILabel!
    @IBOutlet weak var publicIPLabel: UILabel!
    @IBOutlet weak var encryptionOptionLabel: UILabel!
    @IBOutlet weak var disconnectButton: CustomButton!
    @IBOutlet var labels: [UILabel]!
    
    
    // APIManager and VPNConfiguration options
    var apiManager: VPNAPIManager! {
        didSet {
            vpnConfiguration = apiManager.vpnConfiguration
        }
    }

    var vpnConfiguration: VPNConfiguration?
    
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Colors
        for label in labels {
            label.textColor = .primaryFont
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // setup the UI depending on the apiManager's current status
        switch apiManager.status {
        case .statusConnecting:
            statusConnectionWillBegin()
        case .statusConnected:
            statusConnectionSucceeded()
        case .statusDisconnecting:
            statusConnectionWillDisconnect()
        case .statusDisconnected:
            statusConnectionDidDisconnect()
        default:
            statusConnectionDidDisconnect()
        }
        
        NotificationCenter.default.addObserver(for: self)
    }
    
    override func viewDidLayoutSubviews() {
        // Button styling
        disconnectButton.borderColor = UIColor.disconnectButton.cgColor
        disconnectButton.fillColor = UIColor.disconnectButton.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(for: self)
    }
    
    // MARK: IBActions
    @IBAction func disconnect(sender: UIButton) {
        if let isOnDemandAlwaysOn = vpnConfiguration?.getOptionForKey(kOnDemandEnabledKey) as? Bool,
            isOnDemandAlwaysOn != false {
            
            let alert = UIAlertController(title: LocalizedString.onDemandConnectedAlertTitle, message: LocalizedString.onDemandConnectedAlertMessage, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction.init(title: LocalizedString.cancel, style: .cancel, handler: nil)
            
            let confirmAction = UIAlertAction.init(title: LocalizedString.onDemandConnectedAlertConfirm, style: .default, handler: { (UIAlertAction) in
                self.apiManager.disconnect()
                self.vpnConfiguration?.setOption(NSNumber.init(booleanLiteral: false), forKey: kOnDemandEnabledKey)
                self.apiManager.installHelperAndConnect(onInstall: false)
            })
            
            alert.addAction(cancelAction)
            alert.addAction(confirmAction)
            
            present(alert, animated: true, completion: nil)
            
        } else {
            apiManager.disconnect()
        }
    }
    
    // MARK: Helper Methods
    
    /// This helper method takes the passed in VPNConfiguration object to determine what the current location
    /// string should say when presented to the user. This method is mainly used to format out the number the API
    /// will kick back at times. e.g. "0, New Zealand" to instead become: "New Zealand" or "Loading" if the location
    /// has not been determined yet.
    ///
    /// - Parameter vpnConfiguration: The configuration object for VPN Services
    /// - Returns: A formatted text based on the parameter's location contents to display to the user
    func locationString(for vpnConfiguration: VPNConfiguration?) -> String {
        // If the location text does not exist, display loading.
        // If the location text exists, but has a number in the text, display just the country name
        // otherwise, display the received location text
        let locationString = vpnConfiguration?.currentLocation?.location() ?? LocalizedString.loading
        // If a number is found, split the string based on the comma + space ', ' and take the second part
        // if it exists
        if locationString.rangeOfCharacter(from: .decimalDigits) != nil {
            // split the string around the comma + space
            let components = locationString.components(separatedBy: ", ")
            if components.count > 0 {
                return components.last!
            } else {
                return locationString
            }
        } else {
            return locationString
        }

    }
    
}

// MARK: - VPNConfigurationStatusReporting
extension DashboardConnectedViewController: VPNConfigurationStatusReporting {
    func statusCurrentLocationDidChange(_ notification: Notification) {
        
        // notification should kick back a VPNConfiguration object
        guard let vpnConfiguration = notification.object as? VPNConfiguration else {
            return
        }
        
        // update the location label and Public IP
        publicIPLabel.text = vpnConfiguration.currentLocation?.ipAddress ?? LocalizedString.loading
        visibleLocationLabel.text = locationString(for: vpnConfiguration)
    }
}

// MARK: - VPNConnectionStatusReporting
extension DashboardConnectedViewController: VPNConnectionStatusReporting {
    
    func statusConnectionWillBegin() {
        // prep for the connected state. Disable buttons in this state
        disconnectButton.isEnabled = false
    }
    
    func statusConnectionSucceeded() {
        // update the current state of the view controller
        disconnectButton.isEnabled = true
        
        publicIPLabel.text = vpnConfiguration?.currentLocation?.ipAddress ?? LocalizedString.loading
        visibleLocationLabel.text = locationString(for: vpnConfiguration)
        
        // update the selected AES encryption label
        guard let vpnConfiguration = vpnConfiguration,
            vpnConfiguration.hasOption(forKey: kIKEv2Encryption),
            let encryptionString = vpnConfiguration.getOptionForKey(kIKEv2Encryption) as? String else {
                return
        }
        
        // depending on which encryption type is selected, display that text on-screen
        if encryptionString == kVPNEncryptionAES256 {
            encryptionOptionLabel.text = LocalizedString.aes256
        } else {
            encryptionOptionLabel.text = LocalizedString.aes128
        }
        
    }
    
    func statusConnectionWillDisconnect() {
        // prep for the disconnected state. Disable buttons in this state
        disconnectButton.isEnabled = false
    }
    
    func statusConnectionDidDisconnect() {
        // The button should be disabled as this view shouldn't be visible during this state
        disconnectButton.isEnabled = false
    }
    
    func statusConnectionFailed(_ notification: Notification) {
        // set the button status back to normal. Parent View Controller will handle alert to user.
        disconnectButton.isEnabled = true
	}
    
}

// MARK: - VPNAccountStatusReporting
extension DashboardConnectedViewController: VPNAccountStatusReporting {
    /// When the dashboard receives this notification, disable all UI while validating user account information which happens automatically.
    /// If the current credentials are incorrect, in the case of China users or a changed password, log the user out (automatic) and
    /// inform the user why they were logged out.
    func statusLoginWillBegin() {
        disconnectButton.isEnabled = false
    }
    
    /// In the event login has succeeded, re-enable the UI that was disabled.
    ///
    /// - Parameter notification: Notification kicked back from the framework. Holds `Account` information.
    func statusLoginSucceeded(_ notification: Notification) {
        disconnectButton.isEnabled = true
    }
    
    /// If the login has failed, for china users or a password change etc, display an alert to the user indicating the login has failed
    /// They will automatically be kicked back to the login view controller
    ///
    /// - Parameter notification: Notification kicked back from the framework. Holds an Error describing reason for failure.
    func statusLoginFailed(_ notification: Notification) {
        disconnectButton.isEnabled = true
    }
}
