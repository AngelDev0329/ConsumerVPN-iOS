//
//  LoginViewController.swift
//  ConsumerVPN
//
//  Created by Amir Nazari on 9/6/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import UIKit
import VPNKit

class LoginViewController: UIViewController {

    // MARK: IBOutets and Variables
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet var separatorViews: [UIView]!
    
    @IBOutlet weak var scrollView: UIScrollView!
    fileprivate var activeField: UITextField?
    
    
    // VPNKit Variables
        // This should have a value through dependency injection. If this doesn't have a value, something went wrong and we should crash
    var apiManager : VPNAPIManager! {
        didSet {
            vpnConfiguration = apiManager.vpnConfiguration
        }
    }

    var vpnConfiguration: VPNConfiguration?
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: LocalizedString.username,
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderFont])
        usernameTextField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: LocalizedString.password,
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderFont])
        passwordTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        loginButton.setTitleColor(.loginBackground, for: .normal)
        forgotButton.setTitleColor(.loginFieldFont, for: .normal)
        
        view.backgroundColor = .loginBackground
        scrollView.backgroundColor = .loginBackground
        for separator in separatorViews {
            separator.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        setupAccessibilityAndLocalization()
    }
    
    override func viewDidLayoutSubviews() {
        // Button styling
        loginButton.fillColor = UIColor.loginButtonBackground.cgColor
        loginButton.borderColor = UIColor.loginButtonBackground.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Listen for VPNKit Notifications
        NotificationCenter.default.addObserver(for: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // If there is an error in the UserDefaults, that means the user was logged off from the dashboard
        // Present an alert to the user with the error description.
        if let localizedErrorDescription = UserDefaults.standard.value(forKey: Theme.loginErrorKey) as? String {
            UserDefaults.standard.set(nil, forKey: Theme.loginErrorKey)
            UserDefaults.standard.synchronize()
            presentAlert(withLocalizedErrorDescription: localizedErrorDescription)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop listening for notifications
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupAccessibilityAndLocalization() {
       // bannerImageView.accessibilityIdentifier = AccessibilityIdentifier.bannerImage.rawValue
    }
    
    // MARK: IBActions
    @IBAction func forgotLogin(sender: UIButton) {
		let url = URL(string: Theme.forgotPasswordURL)!
        
        // Checks to see if url can be opened before attempting to open it.
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func registerButton(sender: UIButton) {
        let url = URL(string: Theme.registerURL)!
        
        // Checks to see if url can be opened before attempting to open it.
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        login()
    }
    
    /// This method is used in place of 'touchesBegan' as the scroll view now intercepts these touch events on the main view.
    /// Use this tap gesture on the scroll view to end editing and dismiss the keyboard
    ///
    /// - Parameter sender: A tap gesture recognizer on the scroll view
    @IBAction func scrollViewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    // MARK: Helper Methods
    /// This function is a helper designed to consolidate the functionality of the login behavior
    /// when the user either taps the login button or presses return on the keyboard after the password field.
    fileprivate func login() {
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespaces),
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces) else {
                return
        }
        
        // ensure the username and password fields are not empty
        guard username.hasText && password.hasText else {
            
            let alertController = UIAlertController(title: LocalizedString.loginErrorAlertTitle,
                                                    message: LocalizedString.loginEmptyField,
                                                    preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: LocalizedString.ok, style: .default, handler: nil)
            alertController.addAction(okButton)
            
            // present the alert to the user
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        apiManager.login(withUsername: username, password: password)
    }
    
    /// This helper method takes in an error to be used in the description of an alert as to why the user couldn't log in
    /// or was forcibly logged out upon login failure notification
    ///
    /// - Parameter error: The error describing why the login failure occurred
    fileprivate func presentAlert(withLocalizedErrorDescription localizedErrorDescription: String) {
        let alertController = UIAlertController(title: LocalizedString.loginErrorAlertTitle,
                                                message: localizedErrorDescription,
                                                preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: LocalizedString.ok, style: .default, handler: nil)
        alertController.addAction(okButton)
        
        // present the alert to the user
        present(alertController, animated: true, completion: nil)
    }

}

// MARK: - Keyboard Notifications
extension LoginViewController {
    
    /// This function is called when the `KeyboardDidShow` notification is posted and will move content up
    ///
    /// - Parameter notification: `userInfo` property contains information on the keyboard
    @objc func keyboardDidShow(notification: NSNotification) {
        guard let info = notification.userInfo,
        let keyboardInfo = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
        let activeField = activeField else { return }
        
        let keyboardSize = keyboardInfo.cgRectValue
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        var aRect = view.frame
        aRect.size.height -= keyboardSize.height
        
        if aRect.contains(activeField.frame.origin) == false {
            scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
        
    }
    
    /// This function is called when the `KeyboardWillHide` notification is posted and will move the content back to the original position
    ///
    /// - Parameter notification: `userInfo` property contains information on the keyboard
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if usernameTextField === textField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            login()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        scrollView.isScrollEnabled = true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
        scrollView.isScrollEnabled = false
    }
}

// MARK: - VPNAccountStatusReporting
extension LoginViewController: VPNAccountStatusReporting {
    
    func statusLoginSucceeded(_ notification: Notification) {
        UserDefaults.standard.set(true, forKey: Theme.isInitialLoad)
        
        // Go to the Dashboard
        self.dismiss(animated: true, completion: nil)
    }
    
    func statusLoginFailed(_ notification: Notification) {
        
        guard let error = notification.object as? NSError else { return }
        
        presentAlert(withLocalizedErrorDescription: error.localizedDescription)
    }
}
