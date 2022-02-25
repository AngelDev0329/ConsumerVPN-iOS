//
//  DashboardViewController.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 9/7/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import UIKit
import VPNKit


final class DashboardViewController: UIViewController {
    
    // MARK: IBOutlets and Variables
    /**
     * Controls and manages the DashboardDisconnectedViewController
     */
    @IBOutlet weak var disconnectedContainerView: UIView!
    
    /**
     * Controls and manages the DashboardConnectedViewController
     */
    @IBOutlet weak var connectedContainerView: UIView!
    
    /**
     * Constraint used on the `connectedContainerView` to slide in and out depending on connection state
     */
    @IBOutlet weak var connectedViewCenterXConstraint: NSLayoutConstraint!
    
    /**
     * Label used to display the current security level to the user between secure and speed
     */
    @IBOutlet weak var secureStatusLabel: UILabel!
    @IBOutlet weak var encryptionChoiceView: UIView!
    
    // Button which brings the user to the Settings page from the Dashboard.
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
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
        setupAccessibilityAndLocalization()
        secureStatusLabel.isHidden = true
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.09019607843, blue: 0.1647058824, alpha: 1)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
           let image = UIImage(named: "LOGOTEXT.png")
           imageView.image = image
           navigationItem.titleView = imageView
        
        // This notification will need to be removed on deinit of this instance
        NotificationCenter.default.addObserver(self, selector: #selector(DashboardViewController.resumeFromBackground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    /// Perform any necessary cleanup
    deinit {
        // Remove ourselves from any remaining notifications
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func resumeFromBackground() {
        updateStatusForState()
    }
    
    /// Helper method responsible for setting the accessibility labels and identifiers as well as localizations with our UI
    private func setupAccessibilityAndLocalization() {
        settingsButton.accessibilityLabel = AccessibilityLabel.settingsButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.bool(forKey: Theme.isInitialLoad) {
            settingsButton.isEnabled = false
        }
        
        disconnectedContainerView.isHidden = true
        connectedContainerView.isHidden = true
        
        // subscribe to the VPN notifications we care about. This must go in viewDidLoad for special login flow notifications
        NotificationCenter.default.addObserver(for: self)
        
        // based on the current status of the apiManager's connection, change which state is shown to user
        if apiManager.isConnectedToVPN() {
            // display the connectedContainerView
            disconnectedContainerView.isHidden = true
            connectedContainerView.isHidden = false
            disconnectedContainerView.alpha = 0
            
            // update the constraint to be on screen
            connectedViewCenterXConstraint.constant = 0
            view.layoutSubviews()
        } else {
            // display the disconnectedContainerView
            disconnectedContainerView.isHidden = false
            connectedContainerView.isHidden = true
            disconnectedContainerView.alpha = 1
            
            // update the contraint to be off screen
         //   connectedViewCenterXConstraint.constant = view.frame.width
           // view.layoutSubviews()
        }
        
        // Update UI animations
        updateStatusForState()
        
        // Make sure the views are stacked properly
        view.bringSubviewToFront(connectedContainerView)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // stop listening to all notifications in relation to the VPNStatusReporting
        NotificationCenter.default.removeObserver(for: self)
    }
    
    // This method is used to provide VPN Information to each of the Child View Controllers
    /// This method is used to provide VPN Information (VPNConfiguration and VPNAPIManager) to each of the Child View Controllers
    /// We must provide the information here instead of elsewhere because the `childViewControllers` property doesn't have valid information
    /// when adding to the custom navigation controller. The lifecycle methods of the children view controllers are also called before the parent's.
    ///
    /// - parameter segue:  The storyboard segue defining the relationship between one view controller and another
    /// - parameter sender: The object responsible for the segue occuring
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vpnCommunicator = segue.destination as? VPNStatusReporting {
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            vpnCommunicator.apiManager = apiManager
        }
        
        if let disconnectVC = segue.destination as? DashboardDisconnectedViewController {
            let backItem = UIBarButtonItem()
            backItem.title = "Atrás"
            navigationItem.backBarButtonItem = backItem
            disconnectVC.delegate = self
        }
    }
    
    /// This will update the UI for the dashboard depending on the current VPN state.
    ///
    /// - Parameters:
    ///   - state: current connected state, can be set manually.
    ///   - didFail: Bool to determine if it should show failed animation.
    func updateStatusForState(state : VPNConnectionStatus? = nil, didFail : Bool = false) {
        
        // If no state was set, retrieves apiManager status directly to determine state.
        let connectionStatus = state ?? apiManager.status
        
        // Remove all sublayers from previous animations
        encryptionChoiceView.layer.sublayers = []
        
        // Error occurred, displays error animation and returns
        if didFail {
            Animations.errorXanimation(encryptionChoiceView, lineWidth: 5.5)
            return
        }
        
        /// Gets currently selected encryption option and sets status animation accordingly.
        /// If no option has been set, this will default to AES256.
        guard let selectedEncryption = vpnConfiguration?.getOptionForKey(kIKEv2Encryption) as? String else {
            Animations.setupSecureAnimationUI(encryptionChoiceView, lineWidth: 5.5, color: .white)
            return
        }
        
        // set encryption type for selected encryption
        let encryptionType : VPNEncryption!
        
        if selectedEncryption == kVPNEncryptionAES128 {
            encryptionType = .AES128
        } else {
            encryptionType = .AES256
        }
        
        // sets dashboard status UI and animation for state
        switch connectionStatus {
        case .statusConnected:
            // make sure status label is visible
            secureStatusLabel.isHidden = true
            
            Animations.encryptionDashAnimation(encryptionChoiceView,lineWidth: 5.5, encryptionType: encryptionType.rawValue)
        case .statusConnecting:
            // make sure status label is visible
            secureStatusLabel.isHidden = false
            
            secureStatusLabel.text = LocalizedString.connectingProgress
            Animations.animateIndeterminateDialog(encryptionChoiceView,lineWidth: 5.5)
        default:
            // make sure status label is hidden
            secureStatusLabel.isHidden = true
            
            if encryptionType == .AES128 {
                Animations.setupFastAnimationUI(encryptionChoiceView, lineWidth:5.5, color: .white)
            } else {
                Animations.setupSecureAnimationUI(encryptionChoiceView, lineWidth: 5.5, color: .white)
            }
            break
        }
    }
}

// MARK: - DashboardDisconnectedViewControllerDelegate
extension DashboardViewController: DashboardDisconnectedViewControllerDelegate {
    
    // On AES option change, update UI to reflect changes.
    func aesSelected() {
        updateStatusForState()
    }

    // Display the list of Servers to the user.
    func popSelected() {
        // present on the navigation stack, the server list table view controller
        // WLNavigationController automatically assigns apiManager and VPNConfiguration where 
        // VC conforms to VPNStatusReporting or child protocol
        performSegue(withIdentifier: "toServerListVC", sender: nil)
    }
}

// MARK: - VPNConnectionStatusReporting
extension DashboardViewController: VPNConnectionStatusReporting {
    
    /// Used to log the connection status of `Will Begin`
    func statusConnectionWillBegin() {
        updateStatusForState(state: .statusConnecting)
    }
    
    /// Used to log the connection status of `Did Begin`
    func statusConnectionDidBegin() {
        // Display indeterminate progress showing that the connection process did begin.
    }
    
    /// Transitions the Dashboard's connected state onto the screen via an animation
    func statusConnectionSucceeded() {
        
        // only move forward with the below if not already in the correct state
        guard disconnectedContainerView.isHidden == false else {
            return
        }
        
        updateStatusForState(state: .statusConnected)
		
        connectedViewCenterXConstraint.constant = 0
        connectedContainerView.isHidden = false
        disconnectedContainerView.isHidden = false
        disconnectedContainerView.alpha = 1
        
        // animate the constraint into place
        UIView.animate(withDuration: 0.75,
                       animations: {
                        self.view.layoutSubviews()
                        self.disconnectedContainerView.alpha = 0
            },
                       completion: { (finished) in
                        if finished {
                            self.disconnectedContainerView.isHidden = true
                        }
            }
        )
    }
    
    /// Transitions the Dashboard's connected state off of the screen via an animation
    func statusConnectionDidDisconnect() {

        // only move forward with the below if not already in the correct state
        guard connectedContainerView.isHidden == false else {
            return
        }

        updateStatusForState(state: .statusDisconnected)
		
        connectedViewCenterXConstraint.constant = view.frame.width
        
        connectedContainerView.isHidden = false
        disconnectedContainerView.isHidden = false
        disconnectedContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.75,
                       animations: {
                        self.view.layoutSubviews()
                        self.disconnectedContainerView.alpha = 1
            },
                       completion: { (finished) in
                        if finished {
                            self.connectedContainerView.isHidden = true
                        }
            }
        )
    }
    
    /// This function displays an alert to the user depending on the reason for a failed connection. 
    /// If the reason is something other than a network connection issue, present an alert with the description of the error
    /// and provide the ability to contact support should this problem persist.
    ///
    /// - parameter notification: Notification object kicked back from the VPNKit. The notification's `object` property is an NSError describing the reason for failure
    func statusConnectionFailed(_ notification: Notification) {
        
        // make sure status label is hidden
        secureStatusLabel.isHidden = true
        updateStatusForState(didFail: true)
        
        // Removes error animation after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            self.updateStatusForState()
        })
		
		guard let error = notification.object as? Error else {
			print("Connection Failed with No Error")
			return
		}
		
        if apiManager.networkIsReachable { // Contact Support
            present(UIAlertController.contactSupport(with: error), animated: true, completion: nil)
        } else { // Network Connection Issue
            present(UIAlertController.network(), animated: true, completion: nil)
        }
        
    }
}

// MARK: - VPNServerStatusReporting
extension DashboardViewController : VPNServerStatusReporting {
    func statusInitialServerUpdateWillBegin() {
        UserDefaults.standard.set(true, forKey: Theme.isInitialLoad)
        
        // Temporarily disable settings button
        settingsButton.isEnabled = false
        
        // make sure status label is visible
        secureStatusLabel.isHidden = false
        
        secureStatusLabel.text = LocalizedString.initialServerListBegin
        Animations.animateIndeterminateDialog(encryptionChoiceView, lineWidth: 5.5)
    }
    
    func statusInitialServerUpdateSucceeded(_ notification: Notification) {
        UserDefaults.standard.set(false, forKey: Theme.isInitialLoad)
        
        // Enable settings button
        settingsButton.isEnabled = true
        
        // make sure status label is hidden
        secureStatusLabel.isHidden = true
        
        Animations.checkmarkAnimation(encryptionChoiceView, lineWidth: 5.5)
        
        // Removes checkmark animation after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.updateStatusForState()
        })
	}
    
    func statusInitialServerUpdateFailed(_ notification: Notification) {
        UserDefaults.standard.set(false, forKey: Theme.isInitialLoad)
        
        // Enable settings button
        settingsButton.isEnabled = true
        
        // make sure status label is hidden
        secureStatusLabel.isHidden = true
        
        Animations.errorXanimation(encryptionChoiceView, lineWidth: 5.5)
        
        // Removes error animation after 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.updateStatusForState()
        })
    }
}

// MARK: - VPNHelperStatusReporting
extension DashboardViewController : VPNHelperStatusReporting {
    func statusHelperInstallFailed(_ notification: Notification) {
        updateStatusForState()
    }
}

// MARK: - VPNAccountStatusReporting
extension DashboardViewController: VPNAccountStatusReporting {
    /// When the dashboard receives this notification, disable all UI while validating user account information which happens automatically.
    /// If the current credentials are incorrect, in the case of China users or a changed password, log the user out (automatic) and 
    /// inform the user why they were logged out.
    func statusLoginWillBegin() {
        // Disable settings button
        settingsButton.isEnabled = false
        
        // make sure the status label is visible
        secureStatusLabel.isHidden = false
        secureStatusLabel.text = LocalizedString.loggingInProgress
        
        Animations.animateIndeterminateDialog(encryptionChoiceView, lineWidth: 5.5)
    }
    
    /// In the event login has succeeded, re-enable the UI that was disabled and hide the secure statusLabel.
    ///
    /// - Parameter notification: Notification kicked back from the framework. Holds `Account` information.
    func statusLoginSucceeded(_ notification: Notification) {
        settingsButton.isEnabled = true
        secureStatusLabel.isHidden = true
        
        updateStatusForState()
    }
    
    /// If the login has failed, for china users or a password change etc, display an alert to the user indicating the login has failed
    /// They will automatically be kicked back to the login view controller
    ///
    /// - Parameter notification: Notification kicked back from the framework. Holds an Error describing reason for failure.
    func statusLoginFailed(_ notification: Notification) {
        settingsButton.isEnabled = true
		
		guard let error = notification.object as? Error else {
			print("Login Failed with No Error")
			return
		}
		
        // Save to UserDefaults the localized error message received to be displayed to the user in the Login View Controller
        UserDefaults.standard.set(error.localizedDescription, forKey: Theme.loginErrorKey)
        UserDefaults.standard.synchronize()
    }
    
    
}
