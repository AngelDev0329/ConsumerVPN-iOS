//
//  DashboardDisconnectedViewController.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 9/12/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import UIKit
import VPNKit

final class DashboardDisconnectedViewController: UIViewController {

    // MARK: IBOutlets and Variables
    @IBOutlet weak var aes256Button: CustomButton!
    @IBOutlet weak var aes128Button: CustomButton!
    @IBOutlet weak var popButton: CustomButton!
    @IBOutlet weak var connectButton: CustomButton!
    @IBOutlet weak var encryptionPreferenceLabel: UILabel!
    
    // currently selected encryption
    var selectedEncryptionButton: CustomButton!
    
    // APIManager and VPNConfiguration options
    var apiManager: VPNAPIManager! {
        didSet {
            vpnConfiguration = apiManager.vpnConfiguration
        }
    }

    var vpnConfiguration: VPNConfiguration?
    
    // Delegating out to parent view controller
    var delegate: DashboardDisconnectedViewControllerDelegate!
    
    /**
     * Used to determine whether we should connect immediately after installing the helper or not
     */
    fileprivate var shouldConnect = false
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update the selected AES encryption label
        let selectedEncryption: VPNEncryption
        if let vpnConfiguration = vpnConfiguration,
            vpnConfiguration.hasOption(forKey: kIKEv2Encryption),
            let encryptionString = vpnConfiguration.getOptionForKey(kIKEv2Encryption) as? String {
            
            if encryptionString == kVPNEncryptionAES256 {
                selectedEncryption = .AES256
            } else {
                selectedEncryption = .AES128
            }
        } else {
            // default to AES256 and set the option
            selectedEncryption = .AES256
        }
        
        setButtonState(for: aes256Button, selected: selectedEncryption == .AES256)
        setButtonState(for: aes128Button, selected: selectedEncryption == .AES128)
        
        popButton.setTitleColor(.primaryFont, for: .normal)
        connectButton.setTitleColor(.primaryFont, for: .normal)
        encryptionPreferenceLabel.textColor = .primaryFont
        
        // finish off with setting accessibility and localization information
        setupAccessibilityAndLocalization()
    }
    
    override func viewDidLayoutSubviews() {
        // Button styling
        aes128Button.borderColor = #colorLiteral(red: 0.7960784314, green: 0.8588235294, blue: 0.1647058824, alpha: 1)
        aes256Button.borderColor = #colorLiteral(red: 0.7960784314, green: 0.8588235294, blue: 0.1647058824, alpha: 1)
        popButton.borderColor = UIColor.white.cgColor
        connectButton.borderColor = UIColor.connectButton.cgColor
        connectButton.fillColor = UIColor.connectButton.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.bool(forKey: Theme.isInitialLoad) == true {
            enableButtons(isEnabled: false)
        }
        
        // subscribe to the VPN notifications we care about
        NotificationCenter.default.addObserver(for: self)
        
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
        
        // Set the title of the PoP button
        popButtonSetTitle(for: vpnConfiguration?.city)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unsubscribe from all notifications
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Helper method responsible for setting the accessibility labels and identifiers as well as localizations with our UI
    private func setupAccessibilityAndLocalization() {
        popButton.accessibilityIdentifier = AccessibilityIdentifier.popSelection.rawValue
    }

    // MARK: IBActions
    @IBAction func connect(sender: CustomButton) {
        shouldConnect = true
        apiManager.connect()
    }
    
    @IBAction func popSelected(sender: CustomButton) {
        // Bring up the servers list view controller.
        // Delegate this task out to the parent view controller
        delegate.popSelected()
    }
    
    @IBAction func aesSelected(sender: CustomButton) {
        
        // determines which encryption type button was tapped
        if sender === aes256Button {
            // Set encryption option
            vpnConfiguration?.setOption(kVPNEncryptionAES256, forKey: kIKEv2Encryption)
        } else {
            // Set encryption option
            vpnConfiguration?.setOption(kVPNEncryptionAES128, forKey: kIKEv2Encryption)
        }
        // Delegate method to notify dashboard that new encryption type has been selected.
        delegate.aesSelected()
        
        setButtonState(for: aes256Button, selected: sender === aes256Button)
        setButtonState(for: aes128Button, selected: sender === aes128Button)
    
        // install helper to commit changes
        apiManager.installHelperAndConnect(onInstall: false)
    }
    
    // MARK: Helper Methods
    
    /// Helper method used to alter the state of the AES Buttons depending on whether it was selected or not
    ///
    /// - parameter button:   The button to change the current state of. State information includes background image and textColor
    /// - parameter selected: Boolean to determine whether to set the state to Active or Inactive
    private func setButtonState(for button: CustomButton, selected: Bool) {
        var textColor: UIColor?
        
        if selected {
            button.backgroundColor = #colorLiteral(red: 0.7960784314, green: 0.8588235294, blue: 0.1647058824, alpha: 1)
            textColor = #colorLiteral(red: 0, green: 0.1411764706, blue: 0.2235294118, alpha: 1)
            button.isActive = true
            button.isEnabled = false
            // set the currently selected button
            selectedEncryptionButton = button
        } else {
            button.backgroundColor = .clear
            textColor = .primaryFont
            button.isActive = false
            button.isEnabled = true
        }
        
        button.setTitleColor(textColor, for: .normal)
    }
    
    // helper to consolidate the server and city change functionality
    fileprivate func popButtonSetTitle(for city: City?) {
        
        let displayString: String
        
        if let city = city,
            let cityModel = CityModel(city: city) {
            displayString = cityModel.cityDisplayName
        } else {
            displayString = LocalizedString.bestAvailableLocation
        }
        
        popButton.setTitle(displayString, for: .normal)
    }
    
    fileprivate func enableButtons(isEnabled: Bool) {
        popButton.isEnabled = isEnabled
        
        // only re-enable the encryption button that IS NOT the currently selected one
        aes128Button.isEnabled = isEnabled && selectedEncryptionButton !== aes128Button
        aes256Button.isEnabled = isEnabled && selectedEncryptionButton !== aes256Button
        
        connectButton.isEnabled = isEnabled
    }
    
}

// MARK: - VPNHelperStatusReporting
extension DashboardDisconnectedViewController: VPNHelperStatusReporting {
    
    // Helper should be installed here
    func statusHelperShouldInstall(_ notification: Notification) {
        apiManager.installHelperAndConnect(onInstall: shouldConnect)
        shouldConnect = false
    }
    
    func statusHelperInstallFailed(_ notification: Notification) {
        // set the UI back to defaults
        enableButtons(isEnabled: true)
        
        if let error = notification.object as? Error {
            print("Helper Install Failed with Error - \(error.localizedDescription)")
        }
    }
    
}

// MARK: - VPNConfigurationStatusReporting
extension DashboardDisconnectedViewController: VPNConfigurationStatusReporting {
    
    func statusCurrentServerDidChange(_ notification: Notification) {
        guard let vpnConfiguration = notification.object as? VPNConfiguration else {
            return
        }
        popButtonSetTitle(for: vpnConfiguration.city)
        
        // If connecting or connected state, return. (This is to avoid a UI glitch caused by re-enabling the connect button)
        if apiManager.status == .statusConnecting || apiManager.status == .statusConnected {
            return
        }
    }
    
    func statusCurrentCityDidChange(_ notification: Notification) {
        guard let vpnConfiguration = notification.object as? VPNConfiguration else {
            return
        }
        popButtonSetTitle(for: vpnConfiguration.city)
    }
    
}

// MARK: - VPNConnectionStatusReporting
extension DashboardDisconnectedViewController: VPNConnectionStatusReporting {
    
    func statusConnectionWillBegin() {
        // set the state of our view controller. This should disable any appropriate buttons
        enableButtons(isEnabled: false)
    }
    
    func statusConnectionSucceeded() {
        // this view controller shouldn't be visible when connected, so disable any appropriate buttons
        enableButtons(isEnabled: false)
    }
    
    func statusConnectionWillDisconnect() {
        // set the state of our view controller. This should disable any appropriate buttons
        enableButtons(isEnabled: false)
    }
    
    func statusConnectionDidDisconnect() {
        if UserDefaults.standard.bool(forKey: Theme.isInitialLoad) == true {
            return
        }
        
        // enable everything
        enableButtons(isEnabled: true)
    }
    
    func statusConnectionFailed(_ notification: Notification) {
        // set the state of our view controller. This should re-enable any appropriate buttons
        // parent view controller is responsible for displaying alert to the user
        enableButtons(isEnabled: true)
        
        // error logged in container view controller
    }
}

// MARK: - VPNServerStatusReporting
extension DashboardDisconnectedViewController : VPNServerStatusReporting {
    func statusInitialServerUpdateWillBegin() {
        enableButtons(isEnabled: false)
        UserDefaults.standard.set(true, forKey: Theme.isInitialLoad)
        popButton.setTitle(LocalizedString.serverUpdateBegin, for: .normal)
    }
    
    func statusInitialServerUpdateSucceeded(_ notification: Notification) {
        enableButtons(isEnabled: true)
        UserDefaults.standard.set(false, forKey: Theme.isInitialLoad)
        popButton.setTitle(LocalizedString.bestAvailableLocation, for: .normal)
    }
    
    func statusInitialServerUpdateFailed(_ notification: Notification) {
        UserDefaults.standard.set(false, forKey: Theme.isInitialLoad)
        enableButtons(isEnabled: true)
    }
    
    func statusServerUpdateWillBegin() {
        if apiManager.status == .statusDisconnected {
            enableButtons(isEnabled: false)
            popButton.setTitle(LocalizedString.serverUpdateBegin, for: .normal)
        }
    }
    
    func statusServerUpdateSucceeded(_ notification: Notification) {
        if apiManager.status == .statusDisconnected {
            enableButtons(isEnabled: true)
            popButtonSetTitle(for: vpnConfiguration?.city)
        }
    }
    
    func statusServerUpdateFailed(_ notification: Notification) {
        enableButtons(isEnabled: true)
        popButton.setTitle(LocalizedString.bestAvailableLocation, for: .normal)
    }
}

// MARK: - VPNAccountStatusReporting
extension DashboardDisconnectedViewController: VPNAccountStatusReporting {
    /// When the dashboard receives this notification, disable all UI while validating user account information which happens automatically.
    /// If the current credentials are incorrect, in the case of China users or a changed password, log the user out (automatic) and
    /// inform the user why they were logged out.
    func statusLoginWillBegin() {
        enableButtons(isEnabled: false)
    }
    
    /// In the event login has succeeded, re-enable the UI that was disabled.
    ///
    /// - Parameter notification: Notification kicked back from the framework. Holds `Account` information.
    func statusLoginSucceeded(_ notification: Notification) {
        enableButtons(isEnabled: true)
    }
    
    /// If the login has failed, for china users or a password change etc, display an alert to the user indicating the login has failed
    /// They will automatically be kicked back to the login view controller
    ///
    /// - Parameter notification: Notification kicked back from the framework. Holds an Error describing reason for failure.
    func statusLoginFailed(_ notification: Notification) {
        enableButtons(isEnabled: true)
    }
}
